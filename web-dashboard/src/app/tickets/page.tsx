import React from 'react';

export default function TicketsPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header">
        <h1>Tickets & Work Orders</h1>
        <p>Manage maintenance tasks and citizen complaints</p>
      </header>
      <div style={{ padding: '40px', textAlign: 'center', backgroundColor: 'white', borderRadius: '12px' }}>
        <h3>No active work orders</h3>
        <p style={{ color: '#718096' }}>All systems are functioning normally.</p>
      </div>
    </div>
  );
}
