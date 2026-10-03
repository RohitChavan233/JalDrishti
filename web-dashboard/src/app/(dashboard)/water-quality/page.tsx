'use client';
import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { Droplet, Activity, AlertTriangle } from 'lucide-react';

const turbidityData = [
  { time: '00:00', value: 0.8 },
  { time: '04:00', value: 0.9 },
  { time: '08:00', value: 1.1 },
  { time: '12:00', value: 1.4 },
  { time: '16:00', value: 2.1 },
  { time: '20:00', value: 1.5 },
  { time: '24:00', value: 1.2 },
];

const chlorineData = [
  { time: '00:00', value: 0.5 },
  { time: '04:00', value: 0.5 },
  { time: '08:00', value: 0.4 },
  { time: '12:00', value: 0.3 },
  { time: '16:00', value: 0.2 },
  { time: '20:00', value: 0.4 },
  { time: '24:00', value: 0.5 },
];

const sensors = [
  { id: 'SN-402', location: 'Shirur Main ESR', type: 'Turbidity', value: '1.2 NTU', status: 'Normal', lastUpdate: '2 mins ago' },
  { id: 'SN-405', location: 'Bhor GP Tank', type: 'Chlorine', value: '0.1 mg/L', status: 'Warning', lastUpdate: '5 mins ago' },
  { id: 'SN-411', location: 'Khed Water Plant', type: 'pH Level', value: '7.4', status: 'Normal', lastUpdate: '1 min ago' },
  { id: 'SN-422', location: 'Baramati Pumping Station', type: 'TDS', value: '450 ppm', status: 'Normal', lastUpdate: '10 mins ago' },
];

export default function WaterQualityPage() {
  return (
    <div className="dashboard-container fade-in">
      <header className="page-header flex justify-between items-center" style={{ display: 'flex', justifyContent: 'space-between' }}>
        <div>
          <h1>Water Quality Telemetry</h1>
          <p>Real-time sensor data and historical lab test results</p>
        </div>
        <button className="btn-secondary" style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
          Download Report
        </button>
      </header>
      
      {/* KPI Cards */}
      <div className="kpi-grid">
        <div className="kpi-card" style={{ borderLeft: '4px solid var(--status-green)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
            <h3 style={{ margin: 0 }}>Avg Turbidity</h3>
            <Droplet size={20} color="var(--status-green)" />
          </div>
          <div className="kpi-value">1.2 <span style={{fontSize: '16px', color: '#718096'}}>NTU</span></div>
          <div className="kpi-trend positive">Safe limits • Normal</div>
        </div>
        <div className="kpi-card" style={{ borderLeft: '4px solid var(--status-amber)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
            <h3 style={{ margin: 0 }}>Residual Chlorine</h3>
            <Activity size={20} color="var(--status-amber)" />
          </div>
          <div className="kpi-value">0.2 <span style={{fontSize: '16px', color: '#718096'}}>mg/L</span></div>
          <div className="kpi-trend negative" style={{color: 'var(--status-amber)'}}>Approaching low limit</div>
        </div>
        <div className="kpi-card" style={{ borderLeft: '4px solid var(--status-green)' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
            <h3 style={{ margin: 0 }}>Average pH</h3>
            <Activity size={20} color="var(--status-green)" />
          </div>
          <div className="kpi-value">7.3</div>
          <div className="kpi-trend positive">Optimal • Stable</div>
        </div>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px', marginTop: '32px' }}>
        {/* Turbidity Chart */}
        <div className="kpi-card" style={{ padding: '24px' }}>
          <h3 style={{ marginBottom: '24px', color: 'var(--primary-blue)', fontSize: '16px' }}>24h Turbidity Trend (NTU)</h3>
          <div style={{ width: '100%', height: 300 }}>
            <ResponsiveContainer>
              <AreaChart data={turbidityData}>
                <defs>
                  <linearGradient id="colorTurbidity" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#007D8C" stopOpacity={0.3}/>
                    <stop offset="95%" stopColor="#007D8C" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E2E8F0" />
                <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{fill: '#718096', fontSize: 12}} />
                <YAxis axisLine={false} tickLine={false} tick={{fill: '#718096', fontSize: 12}} />
                <Tooltip contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }} />
                <Area type="monotone" dataKey="value" stroke="#007D8C" strokeWidth={3} fillOpacity={1} fill="url(#colorTurbidity)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Chlorine Chart */}
        <div className="kpi-card" style={{ padding: '24px' }}>
          <h3 style={{ marginBottom: '24px', color: 'var(--primary-blue)', fontSize: '16px' }}>24h Residual Chlorine Trend (mg/L)</h3>
          <div style={{ width: '100%', height: 300 }}>
            <ResponsiveContainer>
              <AreaChart data={chlorineData}>
                <defs>
                  <linearGradient id="colorChlorine" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#DD6B20" stopOpacity={0.3}/>
                    <stop offset="95%" stopColor="#DD6B20" stopOpacity={0}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E2E8F0" />
                <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{fill: '#718096', fontSize: 12}} />
                <YAxis axisLine={false} tickLine={false} tick={{fill: '#718096', fontSize: 12}} />
                <Tooltip contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }} />
                <Area type="monotone" dataKey="value" stroke="#DD6B20" strokeWidth={3} fillOpacity={1} fill="url(#colorChlorine)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Sensor Table */}
      <div className="kpi-card" style={{ marginTop: '32px', padding: 0, overflow: 'hidden' }}>
        <div style={{ padding: '20px 24px', borderBottom: '1px solid var(--border-color)', display: 'flex', justifyContent: 'space-between' }}>
          <h3 style={{ margin: 0, fontSize: '16px' }}>Live Sensor Telemetry</h3>
          <button className="btn-text">Manage Sensors</button>
        </div>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
          <thead>
            <tr style={{ backgroundColor: '#F7FAFC', borderBottom: '1px solid var(--border-color)' }}>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Sensor ID</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Location</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Parameter</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Current Value</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Status</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Last Sync</th>
            </tr>
          </thead>
          <tbody>
            {sensors.map((s, i) => (
              <tr key={i} style={{ borderBottom: '1px solid var(--border-color)' }}>
                <td style={{ padding: '16px 24px', fontWeight: 500 }}>{s.id}</td>
                <td style={{ padding: '16px 24px' }}>{s.location}</td>
                <td style={{ padding: '16px 24px', color: '#4A5568' }}>{s.type}</td>
                <td style={{ padding: '16px 24px', fontWeight: 600 }}>{s.value}</td>
                <td style={{ padding: '16px 24px' }}>
                  <span style={{ 
                    padding: '4px 12px', 
                    borderRadius: '16px', 
                    fontSize: '12px',
                    fontWeight: 600,
                    backgroundColor: s.status === 'Normal' ? '#C6F6D5' : '#FEEBC8',
                    color: s.status === 'Normal' ? '#22543D' : '#7B341E'
                  }}>
                    {s.status}
                  </span>
                </td>
                <td style={{ padding: '16px 24px', color: '#A0AEC0', fontSize: '13px' }}>{s.lastUpdate}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
