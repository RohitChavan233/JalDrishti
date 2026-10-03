import React from 'react';

export default function SettingsPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header">
        <h1>Settings</h1>
        <p>System configuration and user preferences</p>
      </header>
      <div style={{ padding: '40px', backgroundColor: 'white', borderRadius: '12px' }}>
        <p>Configuration options will appear here.</p>
      </div>
    </div>
  );
}
