import { mkdir, readFile, writeFile } from 'node:fs/promises'
import { fileURLToPath } from 'node:url'
import path from 'node:path'

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..')
const sourceDir = path.join(root, 'image-parts')
const outputDir = path.join(root, 'public', 'images')
const manifest = JSON.parse(await readFile(path.join(sourceDir, 'manifest.json'), 'utf8'))

await mkdir(outputDir, { recursive: true })

for (const [filename, spec] of Object.entries(manifest)) {
  let encoded = ''

  for (let part = 1; part <= spec.parts; part += 1) {
    const suffix = String(part).padStart(2, '0')
    encoded += await readFile(path.join(sourceDir, `${filename}.part${suffix}`), 'utf8')
  }

  const binary = Buffer.from(encoded.replace(/\s+/g, ''), 'base64')

  if (binary.length !== spec.bytes) {
    throw new Error(`Image reconstruction failed for ${filename}: expected ${spec.bytes} bytes, got ${binary.length}`)
  }

  if (binary.subarray(0, 4).toString('ascii') !== 'RIFF' || binary.subarray(8, 12).toString('ascii') !== 'WEBP') {
    throw new Error(`Image reconstruction failed for ${filename}: invalid WebP signature`)
  }

  await writeFile(path.join(outputDir, filename), binary)
  console.log(`materialized ${filename} (${binary.length} bytes)`)
}
