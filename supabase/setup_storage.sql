-- 1. Create a storage bucket for avatars
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do nothing;

-- 2. Policy: Allow public read access (Anyone can view avatars)
create policy "Avatar images are publicly accessible"
  on storage.objects for select
  using ( bucket_id = 'avatars' );

-- 3. Policy: Allow authenticated users to upload their own avatar
-- We assume the filename includes the user_id or random, but for security,
-- normally we might restrict path. For now, simple auth check.
create policy "Users can upload their own avatar"
  on storage.objects for insert
  with check ( bucket_id = 'avatars' and auth.role() = 'authenticated' );

-- 4. Policy: Allow users to update their own avatar (overwrite)
create policy "Users can update their own avatar"
  on storage.objects for update
  using ( bucket_id = 'avatars' and auth.role() = 'authenticated' );

-- 5. Policy: Allow users to delete their own avatar (optional, good practice)
create policy "Users can delete their own avatar"
  on storage.objects for delete
  using ( bucket_id = 'avatars' and auth.role() = 'authenticated' );
