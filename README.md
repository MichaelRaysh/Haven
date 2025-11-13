Haven Nurse App (Standalone)

This repository contains a standalone HTML version of the Haven nursing app: `nurseApp.html`.

Quick ways to deploy to Netlify

Option A — Connect repository in Netlify UI (recommended)
- Push this repo to GitHub (if not already).
- Open https://app.netlify.com and click "New site from Git".
- Connect your GitHub account, choose this repository and branch (`main`).
- In the build settings set the publish directory to the repository root (`.`) and leave build command blank.
- After provisioning, set the site to use `nurseApp.html` as the SPA entry by adding a `_redirects` file or using `netlify.toml` (this repo already has `netlify.toml` which redirects all routes to `/nurseApp.html`).

Option B — Deploy with Netlify CLI (quick test or manual deploy)
- Install Netlify CLI if needed:

  npm install -g netlify-cli

- Login (interactive):

  netlify login

- Deploy (interactive):

  netlify deploy --dir=.  # for draft URL
  netlify deploy --dir=. --prod  # to publish

You can also use the npm script in this repo:

  npm run deploy

Option C — CI/CD via GitHub Actions (automated on push)
- The repo includes a GitHub Actions workflow at `.github/workflows/netlify-deploy.yml`.
- To use it, add the following GitHub repository secrets:
  - `NETLIFY_AUTH_TOKEN` — a personal access token from Netlify (Account settings > Applications > Personal access tokens)
  - `NETLIFY_SITE_ID` — your Netlify site ID (from Site settings)
- Push to the `main` branch and the workflow will run and deploy.

Notes
- `netlify.toml` is configured to redirect all routes to `nurseApp.html` so Single-file use works.
- If you prefer Netlify GUI continuous deploy, just connect the repo and Netlify will handle builds.

If you'd like, I can:
- Push the current branch to GitHub for you (I will need repo remote access info), or
- Run a local deployment with Netlify CLI (you'll need to run `netlify login` locally), or
- Create a preview deploy if you provide a Netlify token now.
