import React from 'react';
import Link from 'next/link';

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="layout">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="logo-container">
          <div className="logo-icon"></div>
          <h2>JalDrishti</h2>
        </div>
        <nav className="nav-menu">
          <Link href="/" className="nav-item">
            <span className="icon">📊</span> Overview
          </Link>
          <Link href="/map" className="nav-item">
            <span className="icon">🗺️</span> GIS Map
          </Link>
          <Link href="/alerts" className="nav-item">
            <span className="icon">🚨</span> Alerts
          </Link>
          <Link href="/tickets" className="nav-item">
            <span className="icon">🎫</span> Tickets
          </Link>
          <Link href="/water-quality" className="nav-item">
            <span className="icon">💧</span> Water Quality
          </Link>
          <Link href="/settings" className="nav-item">
            <span className="icon">⚙️</span> Settings
          </Link>
          <Link href="/login" className="nav-item" style={{ marginTop: 'auto' }}>
            <span className="icon">🚪</span> Logout
          </Link>
        </nav>
      </aside>

      {/* Main Content */}
      <main className="main-content">
        <header className="top-header">
          <div className="breadcrumbs">
            <span>Maharashtra</span> &gt; <span>Pune District</span>
          </div>
          <div className="user-profile">
            <div className="avatar">JE</div>
            <span>Junior Engineer</span>
          </div>
        </header>
        
        {children}
      </main>
    </div>
  );
}
