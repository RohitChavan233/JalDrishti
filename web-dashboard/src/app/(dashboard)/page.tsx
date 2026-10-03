'use client';
import React, { useEffect, useState } from 'react';
import AlertsList from './AlertsList';
import dynamic from 'next/dynamic';
import { AreaChart, Area, ResponsiveContainer } from 'recharts';
import Link from 'next/link';
import { ArrowRight } from 'lucide-react';

const MapWithNoSSR = dynamic(() => import('./map/MapComponent'), { ssr: false });

const sparklineData1 = [{ v: 92 }, { v: 93 }, { v: 93 }, { v: 94.2 }];
const sparklineData2 = [{ v: 28 }, { v: 26 }, { v: 24 }, { v: 22 }];

export default function Dashboard() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '32px' }}>
        <div>
          <h1>District Overview</h1>
          <p>Real-time monitoring of FHTCs and infrastructure status</p>
        </div>
        <div style={{ color: '#718096', fontSize: '14px', fontWeight: 500 }}>
          Last sync: <span style={{ color: 'var(--status-green)' }}>Live</span>
        </div>
      </header>

      {/* KPIs */}
      <div className="kpi-grid">
        <div className="kpi-card" style={{ position: 'relative', overflow: 'hidden' }}>
          <h3>Functional FHTCs</h3>
          <div className="kpi-value">94.2%</div>
          <div className="kpi-trend positive">↑ 1.2% from last week</div>
          <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, height: '40px', opacity: 0.3 }}>
            <ResponsiveContainer>
              <AreaChart data={sparklineData1}>
                <Area type="monotone" dataKey="v" stroke="#38A169" fill="#C6F6D5" strokeWidth={2} />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>
        <div className="kpi-card">
          <h3>Villages with Supply Today</h3>
          <div className="kpi-value">1,104 <span className="kpi-sub">/ 1,120</span></div>
          <div className="kpi-trend neutral">On schedule</div>
          <div style={{ marginTop: '12px', height: '6px', width: '100%', backgroundColor: '#EDF2F7', borderRadius: '3px' }}>
            <div style={{ height: '100%', width: '98%', backgroundColor: '#3182CE', borderRadius: '3px' }}></div>
          </div>
        </div>
        <div className="kpi-card alert-kpi" style={{ backgroundColor: '#FFF5F5', borderColor: '#FEB2B2' }}>
          <h3 style={{ color: '#C53030' }}>Critical Alerts</h3>
          <div className="kpi-value text-red">3</div>
          <div className="kpi-trend negative" style={{ color: '#C53030' }}>Requires immediate attention</div>
        </div>
        <div className="kpi-card" style={{ position: 'relative', overflow: 'hidden' }}>
          <h3>Avg Resolution Time</h3>
          <div className="kpi-value">22 hrs</div>
          <div className="kpi-trend positive">↓ 4 hrs from last month</div>
          <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, height: '40px', opacity: 0.3 }}>
            <ResponsiveContainer>
              <AreaChart data={sparklineData2}>
                <Area type="monotone" dataKey="v" stroke="#3182CE" fill="#BEE3F8" strokeWidth={2} />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Map and Alerts section */}
      <div className="main-grid">
        <div className="map-section" style={{ display: 'flex', flexDirection: 'column' }}>
          <div className="section-header" style={{ marginBottom: '16px' }}>
            <h2>Live Status Map</h2>
            <Link href="/map" className="btn-secondary" style={{ textDecoration: 'none' }}>Expand Map</Link>
          </div>
          <div style={{ flex: 1, minHeight: '400px', borderRadius: '12px', overflow: 'hidden', border: '1px solid var(--border-color)', boxShadow: '0 4px 6px rgba(0,0,0,0.05)' }}>
            <MapWithNoSSR />
          </div>
        </div>
        
        <div className="alerts-section">
          <div className="section-header">
            <h2>Active Alerts</h2>
            <Link href="/alerts" className="btn-text" style={{ display: 'flex', alignItems: 'center', gap: '4px', textDecoration: 'none' }}>
              View All <ArrowRight size={16} />
            </Link>
          </div>
          <AlertsList />
        </div>
      </div>
    </div>
  );
}
