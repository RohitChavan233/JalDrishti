import React from 'react';

export default function MapPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header">
        <h1>GIS Map</h1>
        <p>Interactive geographic view of all infrastructure and FHTCs</p>
      </header>
      <div className="map-placeholder" style={{ height: '600px' }}>
        <div className="map-overlay">
          <p style={{ textAlign: 'center', marginTop: '280px', color: '#718096' }}>Map loading...</p>
        </div>
      </div>
    </div>
  );
}
