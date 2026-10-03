import React from 'react';
import AlertsList from '../AlertsList';

export default function AlertsPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header">
        <h1>System Alerts</h1>
        <p>All active and historical alerts across the district</p>
      </header>
      <div className="alerts-section" style={{ backgroundColor: 'white', padding: '24px', borderRadius: '12px' }}>
        <AlertsList />
      </div>
    </div>
  );
}
