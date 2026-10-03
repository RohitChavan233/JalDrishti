'use client';
import React, { useState, useEffect } from 'react';
import { Search, Plus, Filter, MoreVertical } from 'lucide-react';

interface Ticket {
  id: string;
  issue: string;
  details: string;
  severity: string;
  status: string;
  time: string;
}

export default function TicketsPage() {
  const [activeTab, setActiveTab] = useState('All');
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState(true);

  // Poll for new tickets every 5 seconds
  useEffect(() => {
    const fetchTickets = async () => {
      try {
        const response = await fetch('/api/tickets');
        if (response.ok) {
          const data = await response.json();
          setTickets(data);
        }
      } catch (error) {
        console.error("Failed to fetch tickets:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchTickets();
    const interval = setInterval(fetchTickets, 5000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="dashboard-container fade-in">
      <header className="page-header flex justify-between items-center" style={{ display: 'flex', justifyContent: 'space-between' }}>
        <div>
          <h1>Tickets & Work Orders</h1>
          <p>Manage maintenance tasks and citizen complaints</p>
        </div>
        <button className="login-btn" style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '10px 20px' }}>
          <Plus size={18} /> Create Work Order
        </button>
      </header>

      <div className="kpi-card" style={{ padding: 0, overflow: 'hidden' }}>
        {/* Toolbar */}
        <div style={{ padding: '20px', borderBottom: '1px solid var(--border-color)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', backgroundColor: '#FAFCFF' }}>
          <div style={{ display: 'flex', gap: '20px' }}>
            {['All', 'Open', 'In Progress', 'Closed'].map(tab => (
              <button 
                key={tab}
                onClick={() => setActiveTab(tab)}
                style={{ 
                  background: 'none', 
                  border: 'none', 
                  fontSize: '15px',
                  fontWeight: activeTab === tab ? 600 : 500,
                  color: activeTab === tab ? 'var(--primary-blue)' : '#718096',
                  borderBottom: activeTab === tab ? '2px solid var(--primary-blue)' : '2px solid transparent',
                  paddingBottom: '4px',
                  cursor: 'pointer'
                }}
              >
                {tab}
              </button>
            ))}
          </div>

          <div style={{ display: 'flex', gap: '12px' }}>
            <div style={{ position: 'relative' }}>
              <Search size={16} color="#A0AEC0" style={{ position: 'absolute', left: '12px', top: '10px' }} />
              <input 
                type="text" 
                placeholder="Search ID, Location..." 
                style={{ 
                  padding: '8px 12px 8px 36px', 
                  borderRadius: '6px', 
                  border: '1px solid var(--border-color)',
                  outline: 'none',
                  fontSize: '14px'
                }} 
              />
            </div>
            <button style={{ display: 'flex', alignItems: 'center', gap: '6px', padding: '8px 16px', background: 'white', border: '1px solid var(--border-color)', borderRadius: '6px', cursor: 'pointer', color: '#4A5568', fontWeight: 500 }}>
              <Filter size={16} /> Filter
            </button>
          </div>
        </div>

        {/* Table */}
        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
          <thead>
            <tr style={{ borderBottom: '1px solid var(--border-color)' }}>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>ID</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Issue / Title</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Details & Location</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Priority</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Status</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Date</th>
              <th style={{ padding: '16px 20px' }}></th>
            </tr>
          </thead>
          <tbody>
            {loading ? (
              <tr>
                <td colSpan={7} style={{ padding: '32px', textAlign: 'center', color: '#718096' }}>Loading tickets...</td>
              </tr>
            ) : tickets.length === 0 ? (
              <tr>
                <td colSpan={7} style={{ padding: '32px', textAlign: 'center', color: '#718096' }}>No tickets found.</td>
              </tr>
            ) : (
              tickets.map((t, i) => (
                <tr key={i} style={{ borderBottom: '1px solid var(--border-color)', backgroundColor: 'white' }}>
                  <td style={{ padding: '16px 20px', fontWeight: 600, color: 'var(--primary-blue)' }}>{t.id}</td>
                  <td style={{ padding: '16px 20px', fontWeight: 500 }}>{t.issue}</td>
                  <td style={{ padding: '16px 20px', color: '#4A5568' }}>{t.details}</td>
                  <td style={{ padding: '16px 20px' }}>
                    <span style={{ 
                      color: t.severity === 'high' ? '#E53E3E' : t.severity === 'medium' ? '#DD6B20' : '#38A169', 
                      fontWeight: 600, fontSize: '13px', textTransform: 'capitalize' 
                    }}>
                      {t.severity}
                    </span>
                  </td>
                  <td style={{ padding: '16px 20px' }}>
                    <span style={{ 
                      padding: '4px 10px', 
                      borderRadius: '4px', 
                      fontSize: '12px',
                      fontWeight: 600,
                      backgroundColor: ['Closed', 'Resolved'].includes(t.status) ? '#E2E8F0' : ['Open', 'Escalated'].includes(t.status) ? '#FED7D7' : '#BEE3F8',
                      color: ['Closed', 'Resolved'].includes(t.status) ? '#4A5568' : ['Open', 'Escalated'].includes(t.status) ? '#9B2C2C' : '#2B6CB0'
                    }}>
                      {t.status}
                    </span>
                  </td>
                  <td style={{ padding: '16px 20px', color: '#718096', fontSize: '13px' }}>
                    {new Date(t.time).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute:'2-digit' })}
                  </td>
                  <td style={{ padding: '16px 20px', color: '#A0AEC0', cursor: 'pointer' }}><MoreVertical size={18} /></td>
                </tr>
              ))
            )}
          </tbody>
        </table>
        
        <div style={{ padding: '16px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px solid var(--border-color)' }}>
          <span style={{ fontSize: '13px', color: '#718096' }}>Showing {tickets.length} entries</span>
          <div style={{ display: 'flex', gap: '8px' }}>
            <button style={{ padding: '6px 12px', border: '1px solid var(--border-color)', background: 'white', borderRadius: '4px', cursor: 'pointer' }}>Previous</button>
            <button style={{ padding: '6px 12px', border: '1px solid var(--border-color)', background: '#EDF2F7', borderRadius: '4px', cursor: 'pointer' }}>1</button>
            <button style={{ padding: '6px 12px', border: '1px solid var(--border-color)', background: 'white', borderRadius: '4px', cursor: 'pointer' }}>Next</button>
          </div>
        </div>
      </div>
    </div>
  );
}
