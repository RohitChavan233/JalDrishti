import React from 'react';

export default function WaterQualityPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header">
        <h1>Water Quality</h1>
        <p>Historical telemetry and lab test results</p>
      </header>
      <div className="kpi-grid">
        <div className="kpi-card" style={{ borderLeft: '4px solid var(--status-green)' }}>
          <h3>Average Turbidity</h3>
          <div className="kpi-value">1.2 NTU</div>
          <div className="kpi-trend positive">Safe limits</div>
        </div>
        <div className="kpi-card" style={{ borderLeft: '4px solid var(--status-green)' }}>
          <h3>Residual Chlorine</h3>
          <div className="kpi-value">0.4 mg/L</div>
          <div className="kpi-trend positive">Adequate</div>
        </div>
      </div>
    </div>
  );
}
