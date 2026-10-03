import React from 'react';

export default function Dashboard() {
  return (
    <div className="layout">
      {/* Sidebar */}
      <aside className="sidebar">
        <div className="logo-container">
          <div className="logo-icon"></div>
          <h2>JalDrishti</h2>
        </div>
        <nav className="nav-menu">
          <a href="#" className="nav-item active">
            <span className="icon">📊</span> Overview
          </a>
          <a href="#" className="nav-item">
            <span className="icon">🗺️</span> GIS Map
          </a>
          <a href="#" className="nav-item">
            <span className="icon">🚨</span> Alerts
          </a>
          <a href="#" className="nav-item">
            <span className="icon">🎫</span> Tickets
          </a>
          <a href="#" className="nav-item">
            <span className="icon">💧</span> Water Quality
          </a>
          <a href="#" className="nav-item">
            <span className="icon">⚙️</span> Settings
          </a>
        </nav>
      </aside>

      {/* Main Content */}
      <main className="main-content">
        {/* Header */}
        <header className="top-header">
          <div className="breadcrumbs">
            <span>Maharashtra</span> &gt; <span>Pune District</span> &gt; <strong>Overview</strong>
          </div>
          <div className="user-profile">
            <div className="avatar">JE</div>
            <span>Junior Engineer</span>
          </div>
        </header>

        {/* Dashboard Content */}
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
              <div className="alert-list">
                <div className="alert-item high-severity">
                  <div className="alert-icon">🚨</div>
                  <div className="alert-details">
                    <h4>Pump Fault Detected</h4>
                    <p>Shirur GP • Motor current zero during schedule</p>
                    <span className="time">10 mins ago</span>
                  </div>
                  <div className="alert-status">Escalated</div>
                </div>
                <div className="alert-item critical-severity">
                  <div className="alert-icon">🧪</div>
                  <div className="alert-details">
                    <h4>Water Quality Breach</h4>
                    <p>Bhor GP • Turbidity exceeds 5 NTU at ESR</p>
                    <span className="time">22 mins ago</span>
                  </div>
                  <div className="alert-status">Advisory Sent</div>
                </div>
                <div className="alert-item medium-severity">
                  <div className="alert-icon">💧</div>
                  <div className="alert-details">
                    <h4>Complaint Cluster: No Water</h4>
                    <p>Khed GP • 5 reports in last hour</p>
                    <span className="time">1 hr ago</span>
                  </div>
                  <div className="alert-status">Investigating</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
      
      <style>{`
        .layout {
          display: flex;
          height: 100vh;
          overflow: hidden;
        }
        
        /* Sidebar */
        .sidebar {
          width: 260px;
          background-color: var(--primary-blue);
          color: white;
          display: flex;
          flex-direction: column;
          box-shadow: 2px 0 10px rgba(0,0,0,0.1);
          z-index: 10;
        }
        
        .logo-container {
          padding: 24px;
          display: flex;
          align-items: center;
          gap: 12px;
          border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .logo-icon {
          width: 32px;
          height: 32px;
          background: linear-gradient(135deg, var(--accent-teal), #4FD1C5);
          border-radius: 8px;
          box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .logo-container h2 {
          color: white;
          margin: 0;
          font-size: 22px;
          letter-spacing: 0.5px;
        }
        
        .nav-menu {
          padding: 24px 0;
          display: flex;
          flex-direction: column;
          gap: 8px;
        }
        
        .nav-item {
          padding: 12px 24px;
          color: rgba(255,255,255,0.7);
          display: flex;
          align-items: center;
          gap: 12px;
          font-weight: 500;
          transition: all 0.2s;
        }
        
        .nav-item:hover, .nav-item.active {
          color: white;
          background-color: rgba(255,255,255,0.1);
          border-right: 4px solid var(--accent-teal);
        }
        
        /* Main Content */
        .main-content {
          flex: 1;
          display: flex;
          flex-direction: column;
          overflow-y: auto;
        }
        
        .top-header {
          height: 70px;
          background-color: var(--surface-color);
          border-bottom: 1px solid var(--border-color);
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 0 32px;
          position: sticky;
          top: 0;
          z-index: 5;
        }
        
        .breadcrumbs {
          color: var(--text-muted);
          font-size: 14px;
        }
        
        .breadcrumbs strong {
          color: var(--primary-blue);
        }
        
        .user-profile {
          display: flex;
          align-items: center;
          gap: 12px;
          font-weight: 500;
        }
        
        .avatar {
          width: 36px;
          height: 36px;
          background-color: var(--secondary-teal);
          color: white;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 14px;
        }
        
        /* Dashboard Container */
        .dashboard-container {
          padding: 32px;
          max-width: 1400px;
          margin: 0 auto;
          width: 100%;
        }
        
        .page-header {
          margin-bottom: 32px;
        }
        
        .page-header h1 {
          font-size: 28px;
          margin-bottom: 8px;
        }
        
        .page-header p {
          color: var(--text-muted);
          font-size: 16px;
        }
        
        /* KPIs */
        .kpi-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
          gap: 24px;
          margin-bottom: 32px;
        }
        
        .kpi-card {
          background-color: var(--surface-color);
          padding: 24px;
          border-radius: 12px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.03);
          border: 1px solid var(--border-color);
          transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .kpi-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        
        .kpi-card h3 {
          font-size: 14px;
          color: var(--text-muted);
          text-transform: uppercase;
          letter-spacing: 0.5px;
          margin-bottom: 12px;
        }
        
        .kpi-value {
          font-size: 32px;
          font-weight: 700;
          color: var(--primary-blue);
          margin-bottom: 8px;
        }
        
        .kpi-sub {
          font-size: 18px;
          color: var(--text-muted);
        }
        
        .text-red {
          color: var(--status-red);
        }
        
        .kpi-trend {
          font-size: 13px;
          font-weight: 500;
        }
        
        .kpi-trend.positive { color: var(--status-green); }
        .kpi-trend.negative { color: var(--status-red); }
        .kpi-trend.neutral { color: var(--text-muted); }
        
        /* Main Grid */
        .main-grid {
          display: grid;
          grid-template-columns: 2fr 1fr;
          gap: 24px;
        }
        
        .section-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 16px;
        }
        
        .section-header h2 {
          font-size: 18px;
        }
        
        .btn-secondary {
          background: white;
          border: 1px solid var(--border-color);
          padding: 8px 16px;
          border-radius: 6px;
          color: var(--text-main);
          font-weight: 500;
          cursor: pointer;
          transition: all 0.2s;
        }
        
        .btn-secondary:hover {
          border-color: var(--secondary-teal);
          color: var(--secondary-teal);
        }
        
        .btn-text {
          background: none;
          border: none;
          color: var(--secondary-teal);
          font-weight: 500;
          cursor: pointer;
        }
        
        .map-section, .alerts-section {
          background-color: var(--surface-color);
          padding: 24px;
          border-radius: 12px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.03);
          border: 1px solid var(--border-color);
        }
        
        .map-placeholder {
          height: 400px;
          background: #E2E8F0;
          border-radius: 8px;
          position: relative;
          overflow: hidden;
          background-image: radial-gradient(#CBD5E0 1px, transparent 1px);
          background-size: 20px 20px;
        }
        
        .map-overlay {
          position: absolute;
          inset: 0;
        }
        
        .map-marker {
          width: 16px;
          height: 16px;
          border-radius: 50%;
          position: absolute;
          transform: translate(-50%, -50%);
          border: 2px solid white;
          box-shadow: 0 2px 4px rgba(0,0,0,0.2);
          cursor: pointer;
        }
        
        .map-marker.green { background-color: var(--status-green); }
        .map-marker.amber { background-color: var(--status-amber); animation: pulse-amber 2s infinite; }
        .map-marker.red { background-color: var(--status-red); animation: pulse-red 2s infinite; }
        
        @keyframes pulse-amber {
          0% { box-shadow: 0 0 0 0 rgba(221, 107, 32, 0.7); }
          70% { box-shadow: 0 0 0 10px rgba(221, 107, 32, 0); }
          100% { box-shadow: 0 0 0 0 rgba(221, 107, 32, 0); }
        }
        
        @keyframes pulse-red {
          0% { box-shadow: 0 0 0 0 rgba(229, 62, 62, 0.7); }
          70% { box-shadow: 0 0 0 10px rgba(229, 62, 62, 0); }
          100% { box-shadow: 0 0 0 0 rgba(229, 62, 62, 0); }
        }
        
        .tooltip {
          position: absolute;
          bottom: 150%;
          left: 50%;
          transform: translateX(-50%);
          background: var(--primary-blue);
          color: white;
          padding: 6px 12px;
          border-radius: 4px;
          font-size: 12px;
          white-space: nowrap;
          opacity: 0;
          transition: opacity 0.2s;
          pointer-events: none;
        }
        
        .map-marker:hover .tooltip {
          opacity: 1;
        }
        
        /* Alerts */
        .alert-list {
          display: flex;
          flex-direction: column;
          gap: 16px;
          height: 400px;
          overflow-y: auto;
          padding-right: 8px;
        }
        
        .alert-item {
          display: flex;
          gap: 16px;
          padding: 16px;
          border-radius: 8px;
          border: 1px solid var(--border-color);
          background: #FAFCFF;
          transition: transform 0.2s;
        }
        
        .alert-item:hover {
          transform: translateX(4px);
        }
        
        .alert-item.critical-severity { border-left: 4px solid var(--status-red); }
        .alert-item.high-severity { border-left: 4px solid var(--status-amber); }
        .alert-item.medium-severity { border-left: 4px solid var(--secondary-teal); }
        
        .alert-icon {
          font-size: 24px;
        }
        
        .alert-details {
          flex: 1;
        }
        
        .alert-details h4 {
          font-size: 15px;
          margin-bottom: 4px;
          color: var(--text-main);
        }
        
        .alert-details p {
          font-size: 13px;
          color: var(--text-muted);
          margin-bottom: 8px;
        }
        
        .time {
          font-size: 12px;
          color: var(--text-muted);
        }
        
        .alert-status {
          font-size: 12px;
          font-weight: 600;
          color: var(--secondary-teal);
          background: rgba(0, 125, 140, 0.1);
          padding: 4px 8px;
          border-radius: 4px;
          align-self: flex-start;
        }
        
        @media (max-width: 1024px) {
          .main-grid {
            grid-template-columns: 1fr;
          }
        }
      `}</style>
    </div>
  );
}
