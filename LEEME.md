# Acuario Mágico — guía rápida

Instalación donde un niño toma foto de su dibujo con el celular y aparece nadando
en la pantalla del proyector, en vivo. Sin build, solo HTML + Supabase + Vercel.

## Archivos
- `index.html` — pantalla del acuario (laptop + proyector)
- `captura.html` — vista para el celular (se abre con el QR)
- `config.js` — tus credenciales de Supabase
- `vercel.json` — deja la URL del celular como `/captura`
- `supabase-setup.sql` — crea tabla, bucket y permisos

## Pasos (10 minutos)

### 1. Supabase
1. Crea un proyecto en supabase.com (plan gratis sirve de sobra).
2. Abre **SQL Editor → New query**, pega todo `supabase-setup.sql` y ejecútalo.
3. Ve a **Project Settings → API** y copia:
   - **Project URL**
   - **anon public key**

### 2. config.js
Pega esos dos valores en `config.js`:
```js
window.ACUARIO_CONFIG = {
  SUPABASE_URL:      "https://xxxx.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGc..."
};
```

### 3. Vercel
1. Sube los archivos a un repo de GitHub.
2. En Vercel: **Add New → Project → Import** ese repo.
3. Framework preset: **Other** (no hay build). Deploy.
4. Tu acuario queda en `https://tu-proyecto.vercel.app`
   y la captura en `https://tu-proyecto.vercel.app/captura`

## Cómo se usa en el evento
1. Abre el acuario en la laptop, ponlo en pantalla completa (F11) en el proyector.
2. Abajo a la izquierda aparece un **QR**: el indicador debe decir "conectado".
3. El niño (o el operador) escanea el QR con el celular → se abre la cámara.
4. Encuadra el dibujo dentro del marco, toca el botón → en 1-2 segundos
   aparece nadando en el proyector. Automático.

## Tips
- Mejor recorte = papel sobre fondo parejo + buena luz (sin sombras duras).
- "Vaciar océano" limpia la pantalla entre tandas.
- Sin internet o sin configurar Supabase, el acuario sigue funcionando en
  modo local (botones "Subir dibujo" / "Usar cámara" en la laptop).
- Cada foto queda guardada en Supabase Storage → de ahí sale el video/recuerdo
  más adelante.
