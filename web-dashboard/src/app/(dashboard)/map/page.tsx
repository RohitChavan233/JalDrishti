import React from 'react';
import dynamic from 'next/dynamic';
import { Filter, Layers } from 'lucide-react';

const MapWithNoSSR = dynamic(() => import('./MapComponent'), { ssr: false });

export default function MapPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header flex justify-between items-center" style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div>
          <h1>GIS Network Map</h1>
          <p>Interactive geographic view of all infrastructure and FHTCs</p>
        </div>
        <div style={{ display: 'flex', gap: '12px' }}>
          <button style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', background: 'white', border: '1px solid var(--border-color)', borderRadius: '8px', fontWeight: 500, cursor: 'pointer' }}>
            <Layers size={18} /> Map Layers
          </button>
          <button style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', background: 'white', border: '1px solid var(--border-color)', borderRadius: '8px', fontWeight: 500, cursor: 'pointer' }}>
            <Filter size={18} /> Filter Status
          </button>
        </div>
      </header>

      <div style={{ background: 'white', padding: '8px', borderRadius: '16px', boxShadow: '0 4px 12px rgba(0,0,0,0.05)', border: '1px solid var(--border-color)' }}>
        <MapWithNoSSR />
      </div>
      
      <div style={{ display: 'flex', gap: '24px', marginTop: '16px', padding: '0 16px' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <span style={{ width: 12, height: 12, borderRadius: '50%', background: '#2563EB' }}></span>
          <span style={{ fontSize: '13px', color: '#4A5568', fontWeight: 500 }}>Normal Operations</span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <span style={{ width: 12, height: 12, borderRadius: '50%', background: '#DD6B20' }}></span>
          <span style={{ fontSize: '13px', color: '#4A5568', fontWeight: 500 }}>Warning / Quality Alert</span>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          <span style={{ width: 12, height: 12, borderRadius: '50%', background: '#E53E3E' }}></span>
          <span style={{ fontSize: '13px', color: '#4A5568', fontWeight: 500 }}>Critical / Faults</span>
        </div>
      </div>
    </div>
  );
}
