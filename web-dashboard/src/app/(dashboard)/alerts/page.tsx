'use client';
import React, { useEffect, useState } from 'react';
import { Search, Filter, AlertCircle, Clock, CheckCircle } from 'lucide-react';

type Ticket = {
  id: string;
  issue: string;
  details: string;
  severity: string;
  status: string;
  time: string;
};

export default function AlertsPage() {
  const [tickets, setTickets] = useState<Ticket[]>([]);

  useEffect(() => {
    fetch('/api/tickets')
      .then(r => r.json())
      .then(data => setTickets(data))
      .catch(e => console.error(e));
  }, []);

  const getTimeAgo = (isoString: string) => {
    const diff = Math.floor((new Date().getTime() - new Date(isoString).getTime()) / 60000);
    if (diff < 1) return 'Just now';
    if (diff < 60) return `${diff} mins ago`;
    return `${Math.floor(diff / 60)} hrs ago`;
  };

  const getSeverityColor = (sev: string) => {
    if (sev === 'critical') return 'var(--status-red)';
    if (sev === 'high') return 'var(--status-amber)';
    return 'var(--status-green)';
  };

  return (
    <div className="dashboard-container fade-in">
      <header className="page-header flex justify-between items-center" style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '24px' }}>
        <div>
          <h1>System Alerts Log</h1>
          <p>Real-time event logging and anomaly detection</p>
        </div>
        <div style={{ display: 'flex', gap: '12px' }}>
          <div style={{ position: 'relative' }}>
            <Search size={16} color="#A0AEC0" style={{ position: 'absolute', left: '12px', top: '12px' }} />
            <input 
              type="text" 
              placeholder="Search alerts..." 
              style={{ padding: '10px 12px 10px 36px', borderRadius: '8px', border: '1px solid var(--border-color)', outline: 'none', fontSize: '14px', width: '250px' }} 
            />
          </div>
          <button style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 16px', background: 'white', border: '1px solid var(--border-color)', borderRadius: '8px', fontWeight: 500, cursor: 'pointer' }}>
            <Filter size={18} /> Filters
          </button>
        </div>
      </header>

      <div className="kpi-card" style={{ padding: 0, overflow: 'hidden' }}>
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
          <thead>
            <tr style={{ backgroundColor: '#F7FAFC', borderBottom: '1px solid var(--border-color)' }}>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Alert Type</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Location / Details</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Severity</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Status</th>
              <th style={{ padding: '16px 24px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Time</th>
              <th style={{ padding: '16px 24px' }}></th>
            </tr>
          </thead>
          <tbody>
            {tickets.map((t, i) => (
              <tr key={t.id || i} style={{ borderBottom: '1px solid var(--border-color)', transition: 'background 0.2s', cursor: 'pointer' }} onMouseOver={e => e.currentTarget.style.backgroundColor = '#FAFCFF'} onMouseOut={e => e.currentTarget.style.backgroundColor = 'transparent'}>
                <td style={{ padding: '16px 24px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ width: 40, height: 40, borderRadius: '8px', display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: `${getSeverityColor(t.severity)}15` }}>
                      <AlertCircle size={20} color={getSeverityColor(t.severity)} />
                    </div>
                    <span style={{ fontWeight: 600, color: 'var(--primary-blue)' }}>{t.issue}</span>
                  </div>
                </td>
                <td style={{ padding: '16px 24px', color: '#4A5568' }}>{t.details}</td>
                <td style={{ padding: '16px 24px' }}>
                  <span style={{ color: getSeverityColor(t.severity), fontWeight: 600, textTransform: 'capitalize', fontSize: '13px' }}>{t.severity}</span>
                </td>
                <td style={{ padding: '16px 24px' }}>
                  <span style={{ padding: '4px 10px', borderRadius: '4px', fontSize: '12px', fontWeight: 600, backgroundColor: '#EDF2F7', color: '#4A5568' }}>
                    {t.status}
                  </span>
                </td>
                <td style={{ padding: '16px 24px', color: '#718096', fontSize: '13px' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <Clock size={14} /> {getTimeAgo(t.time)}
                  </div>
                </td>
                <td style={{ padding: '16px 24px', textAlign: 'right' }}>
                  <button className="btn-text" style={{ fontSize: '13px' }}>Acknowledge</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
