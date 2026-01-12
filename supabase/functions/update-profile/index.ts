import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  // Handle CORS preflight request
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // 1. Authenticate the user via the "Authorization" header
    // The client sends "Bearer <supabase_jwt>"
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      throw new Error("Missing Authorization header");
    }

    // Initialize Supabase Client (still needed for DB access)
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      {
        global: { headers: { Authorization: authHeader } },
      }
    );

    let user;
    let userId;

    // 1. Try standard Supabase Auth (Best for RLS transparency)
    const {
      data: { user: authUser },
      error: userError,
    } = await supabaseClient.auth.getUser();

    if (authUser) {
      user = authUser;
      userId = authUser.id;
      console.log("Authenticated via Standard Supabase Auth:", userId);
    } else {
      console.warn(
        "Standard Auth failed, falling back to manual JWT parsing. Reason:",
        userError?.message
      );

      // 2. Fallback: Manual JWT Parsing (Crucial for Custom Tokens)
      try {
        const jwt = authHeader.replace("Bearer ", "");
        const base64Url = jwt.split(".")[1];
        if (!base64Url) throw new Error("Invalid JWT structure");

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

        console.log("DEBUG RAW PAYLOAD:", JSON.stringify(payload, null, 2));

        userId = payload.sub;
        console.log("Authenticated via Manual JWT Parse:", userId);
      } catch (parseError) {
        console.error("Manual Parse Failed:", parseError);
        throw new Error("Invalid User Token: Unable to parse JWT");
      }
    }

    if (!userId) {
      throw new Error("Invalid User Token: No 'sub' claim found");
    }

    console.log("User ID extracted:", userId);

    // 2. Parse Valid Fields
    const { full_name, bio, avatar_url } = await req.json();

    // 3. Construct Update Object (Dynamic Update)
    const updates: any = {
      updated_at: new Date(),
    };

    if (full_name !== undefined) updates.full_name = full_name;
    if (bio !== undefined) updates.bio = bio;
    if (avatar_url !== undefined) updates.avatar_url = avatar_url;

    // Check if there's anything to update
    if (Object.keys(updates).length <= 1) {
      // Only updated_at is there
      return new Response(JSON.stringify({ message: "No changes detected" }), {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      });
    }

    // 4. Perform Update
    const { data, error } = await supabaseClient
      .from("profiles")
      .update(updates)
      .eq("id", userId) // Ensure we only update the requester's profile
      .select()
      .single();

    if (error) {
      console.error("Update Error:", error);
      throw error;
    }

    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 200,
    });
  } catch (error) {
    console.error("Function Error:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
      status: 400,
    });
  }
});
