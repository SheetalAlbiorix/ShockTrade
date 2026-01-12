import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import {
  createRemoteJWKSet,
  jwtVerify,
  SignJWT,
} from "https://esm.sh/jose@4.14.4";

console.log("Hello from Functions!");

const FIREBASE_PROJECT_ID = Deno.env.get("FIREBASE_PROJECT_ID");
const SUPABASE_JWT_SECRET = Deno.env.get("JWT_SECRET");

// Firebase Public Keys URL
const FIREBASE_JWKS_URL =
  "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com";

serve(async (req) => {
  // CORS headers
  console.log("hello worlds");
  const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
      "authorization, x-client-info, apikey, content-type",
  };

  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    if (!SUPABASE_JWT_SECRET) throw new Error("Missing SUPABASE_JWT_SECRET");
    if (!FIREBASE_PROJECT_ID) throw new Error("Missing FIREBASE_PROJECT_ID");

    const { firebase_token } = await req.json();
    if (!firebase_token) throw new Error("Missing firebase_token in body");

    // 1. Verify Firebase Token
    const JWKS = createRemoteJWKSet(new URL(FIREBASE_JWKS_URL));

    const { payload } = await jwtVerify(firebase_token, JWKS, {
      audience: FIREBASE_PROJECT_ID,
      issuer: `https://securetoken.google.com/${FIREBASE_PROJECT_ID}`,
    });

    console.log("Firebase token verified for UID:", payload.sub);

    // 2. Create Supabase JWT
    const now = Math.floor(Date.now() / 1000);
    const userId = payload.sub;
    const email = payload.email as string;

    const supabaseJwt = await new SignJWT({
      aud: "authenticated",
      role: "authenticated",
      email: email,
      sub: userId,
      app_metadata: {
        provider: "firebase",
        providers: ["firebase"],
      },
      user_metadata: {
        email: email,
        email_verified: payload.email_verified,
        picture: payload.picture,
        name: payload.name,
      },
    })
      .setProtectedHeader({ alg: "HS256", typ: "JWT" })
      .setIssuedAt(now)
      .setExpirationTime(now + 3600) // 1 hour expiration
      .sign(new TextEncoder().encode(SUPABASE_JWT_SECRET));

    return new Response(JSON.stringify({ token: supabaseJwt, user: payload }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    console.error("Error:", error.message);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 401,
    });
  }
});
