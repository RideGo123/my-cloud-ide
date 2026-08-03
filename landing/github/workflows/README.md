# My Cloud IDE (Replit Clone)

## 🚀 Deploy karne ke steps:

1. **GitHub Repository** banayein (public/private) aur yeh saari files usme push karein.

2. **Fly.io** par account banayein (free) aur `FLY_API_TOKEN` generate karein.
   - Fly.io CLI install karein: `flyctl auth login`

3. **GitHub Secrets** mein `FLY_API_TOKEN` daalein (Repo → Settings → Secrets and variables → Actions).

4. **Local terminal** mein (ya GitHub Action se):
   ```bash
   flyctl apps create your-app-name   # same naam jo fly.toml mein likha
   flyctl volumes create code_volume --size 1 --region fra
