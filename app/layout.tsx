import './globals.css';
import NavBar from '../components/NavBar';

export const metadata = {
  title: 'CSCI 150 — Intro to Computer Science',
  description: 'Practice platform for CSCI 150',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <NavBar />
        {children}
      </body>
    </html>
  );
}
