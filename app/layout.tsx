import './globals.css';
import NavBar from '../components/NavBar';

export const metadata = {
  title: 'Pynt — learn Python by writing it',
  description: 'Pynt: the CSCI 150 coding platform.',
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
