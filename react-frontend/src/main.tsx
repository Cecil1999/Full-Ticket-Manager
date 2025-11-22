import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './App.css'
import { App } from './App.tsx'
import { Sidebar } from './Sidebar.tsx'

const root = document.getElementById('root')
if (root)
  root.classList.add("flex")

createRoot(root!).render(
  <StrictMode>
    <Sidebar />
    <App />
  </StrictMode>
)
