-- Drop table if exists to reset schema (User request: clean slate)
drop table if exists public.fcm_tokens;

-- Create a table to store FCM tokens
create table if not exists public.fcm_tokens (
  id text not null, -- Firebase UID is text, not UUID. Removed FK to auth.users.
  device_id text not null, -- Unique Device ID (e.g. Android ID / UUID)
  token text not null, -- The FCM registration token
  device_type text, -- 'android', 'ios', 'web'
  last_active timestamp with time zone default timezone('utc'::text, now()) not null,
  
  -- Composite Primary Key: User + Device ID
  -- A user can have multiple devices. Each device has one entry.
  -- If token changes for same device, we update the row.
  primary key (id, device_id)
);

-- Enable Row Level Security
alter table public.fcm_tokens enable row level security;

-- Policies

-- 1. Users can insert their own tokens
create policy "Users can insert their own tokens"
  on public.fcm_tokens for insert
  with check ( (auth.jwt() ->> 'sub') = id );

-- 2. Users can see their own tokens
create policy "Users can see their own tokens"
  on public.fcm_tokens for select
  using ( (auth.jwt() ->> 'sub') = id );

-- 3. Users can delete their own tokens
create policy "Users can delete their own tokens"
  on public.fcm_tokens for delete
  using ( (auth.jwt() ->> 'sub') = id );

-- 4. Users can update their own tokens
create policy "Users can update their own tokens"
  on public.fcm_tokens for update
  using ( (auth.jwt() ->> 'sub') = id );

-- 4. Service Role (Server) has full access (Edge Functions need this if not using user context)
-- By default, service_role bypasses RLS, so no specific policy needed if `service_role` key is used.
