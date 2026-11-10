# Where it goes: setup

1. Create a project at supabase.com.
2. SQL Editor: paste and run `schema.sql`.
3. Project Settings > API: copy the Project URL and the anon public key.
4. Open `index.html` and replace `PASTE_YOUR_SUPABASE_URL` and `PASTE_YOUR_ANON_KEY` near the top of the script. The anon key is safe in the page because row level security limits every user to their own rows.
5. Deploy: push the folder to GitHub and import it into Vercel (no build settings needed), or drag the folder into Vercel.
6. Open the site, tap Create account, then sign in.
7. Once your account exists, turn off new signups in Supabase: Authentication > Sign In / Providers > disable "Allow new users to sign up".
8. To bring over data from the Claude version, copy its backup text (History tab) and paste it into Restore here.
