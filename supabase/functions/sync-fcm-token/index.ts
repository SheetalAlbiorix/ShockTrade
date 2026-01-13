import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("Missing Authorization header");
    }

    // Initialize Supabase Client
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      {
        global: { headers: { Authorization: authHeader } },
      }
    );

    // 1. Authenticate User
    const {
      data: { user },
      error: userError,
    } = await supabaseClient.auth.getUser();

    let userId = user?.id;

    if (!userId) {
      // Fallback for custom tokens if getUser fails (reusing robust logic)
      try {
        const jwt = authHeader.replace("Bearer ", "");
        const base64Url = jwt.split(".")[1];
        const base64 = base64Url.replace(/-/g, "+").replace(/_/g, "/");
        const jsonPayload = decodeURIComponent(
          atob(base64)
            .split("")
            .map(function (c) {
              return "%" + ("00" + c.charCodeAt(0).toString(16)).slice(-2);
            })
            .join("")
        );
        const payload = JSON.parse(jsonPayload);
        userId = payload.sub;
      } catch (e) {
        console.error("Auth failed:", e);
        throw new Error("Invalid Token");
      }
    }

    if (!userId) throw new Error("Unauthorized");

    // 2. Parse Body
    const { token, device_type, device_id } = await req.json();
    if (!token) throw new Error("Missing FCM token");
    if (!device_id) throw new Error("Missing Device ID");

    // 3. Upsert Token
    console.log(`Syncing token for User: ${userId}, Device: ${device_id}`);

    const { error } = await supabaseClient.from("fcm_tokens").upsert(
      {
        id: userId,
        device_id: device_id,
        token: token,
        device_type: device_type ?? "unknown",
        last_active: new Date().toISOString(),
      },
      { onConflict: "id, device_id" }
    );

    if (error) {
      console.error("Upsert Error:", error);
      throw error;
    }

    console.log("Token synced successfully");

    return new Response(JSON.stringify({ message: "Token synced" }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 400,
    });
  }
});
