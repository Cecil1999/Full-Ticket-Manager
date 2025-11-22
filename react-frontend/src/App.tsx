import { BrowserRouter, Routes, Route } from 'react-router'

export function App() {
  return (
    <div>
      <BrowserRouter>
        <Routes>
          <Route path="/home" element={<>Hello World</>} />
        </Routes>
      </BrowserRouter>
    </div>
  )
}
