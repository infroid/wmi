import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  // Relative asset URLs work on both infroid.github.io/wmi and a custom domain.
  base: './',
  plugins: [react()],
  build: {
    outDir: 'web',
    emptyOutDir: true,
  },
  server: {
    host: true,
    port: 5173,
  },
})
