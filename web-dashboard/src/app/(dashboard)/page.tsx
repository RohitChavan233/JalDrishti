import React from 'react';
import AlertsList from './AlertsList';
export default function Dashboard() {
  return (
    <>
        <div className="dashboard-container fade-in">
          <header className="page-header">
            <h1>District Overview</h1>
            <p>Real-time monitoring of FHTCs and infrastructure status</p>
          </header>

          {/* KPIs */}
          <div className="kpi-grid">
            <div className="kpi-card">
              <h3>Functional FHTCs</h3>
              <div className="kpi-value">94.2%</div>
              <div className="kpi-trend positive">↑ 1.2% from last week</div>
            </div>
            <div className="kpi-card">
              <h3>Villages with Supply Today</h3>
              <div className="kpi-value">1,104 <span className="kpi-sub">/ 1,120</span></div>
              <div className="kpi-trend neutral">On schedule</div>
            </div>
            <div className="kpi-card alert-kpi">
              <h3>Critical Alerts</h3>
              <div className="kpi-value text-red">3</div>
              <div className="kpi-trend negative">Requires immediate attention</div>
            </div>
            <div className="kpi-card">
              <h3>Avg Resolution Time</h3>
              <div className="kpi-value">22 hrs</div>
              <div className="kpi-trend positive">↓ 4 hrs from last month</div>
            </div>
          </div>

          {/* Map and Alerts section */}
          <div className="main-grid">
            <div className="map-section">
              <div className="section-header">
                <h2>Live Status Map</h2>
                <button className="btn-secondary">Expand Map</button>
              </div>
              <div className="map-placeholder">
                <div className="map-overlay">
                  <div className="map-marker amber" style={{ top: '30%', left: '40%' }}>
                    <span className="tooltip">Shirur: Pump Fault</span>
                  </div>
                  <div className="map-marker green" style={{ top: '50%', left: '60%' }}></div>
                  <div className="map-marker green" style={{ top: '60%', left: '30%' }}></div>
                  <div className="map-marker red" style={{ top: '70%', left: '70%' }}>
                    <span className="tooltip">Bhor: Turbidity Spike</span>
                  </div>
                </div>
              </div>
            </div>
            
            <div className="alerts-section">
              <div className="section-header">
                <h2>Active Alerts</h2>
                <button className="btn-text">View All</button>
              </div>
              <AlertsList />
            </div>
          </div>
        </div>
      
      
    </>
  );
}
