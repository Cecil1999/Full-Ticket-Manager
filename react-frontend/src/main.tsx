import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './App.css'
import { App } from './App.tsx'
import { BrowserRouter } from 'react-router'
import { Sidebar } from './Sidebar.tsx'

const root = document.getElementById('root')

createRoot(root!).render(
  <StrictMode>
    <div className="grid xl:grid-cols-[16rem_auto] grid-rows-[4rem_auto] h-screen">
      <Sidebar />
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </div>
  </StrictMode>
)
