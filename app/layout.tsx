import './globals.css';
import NavBar from '../components/NavBar';
import AppBackground from '../components/AppBackground';
import InactivityTimer from '../components/InactivityTimer';

export const metadata = {
  title: 'Pynt — learn Python by writing it',
  description: 'Pynt: the CSCI 150 coding platform.',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <AppBackground />
        <InactivityTimer />
        <NavBar />
        {children}
      </body>
    </html>
  );
}
