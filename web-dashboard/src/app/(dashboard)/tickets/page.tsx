'use client';
import React, { useState } from 'react';
import { Search, Plus, Filter, MoreVertical } from 'lucide-react';

const mockTickets = [
  { id: 'WO-2041', title: 'Main Pump Motor Replacement', location: 'Shirur Pumping Station', assigned: 'Ramesh K.', priority: 'High', status: 'In Progress', date: 'Oct 02, 2026' },
  { id: 'WO-2039', title: 'Pipeline Leakage Repair', location: 'Bhor GP Sector 4', assigned: 'Sanjay M.', priority: 'Medium', status: 'Pending', date: 'Oct 01, 2026' },
  { id: 'TKT-9912', title: 'No Water Supply Complaint', location: 'Khed GP (Multiple)', assigned: 'Unassigned', priority: 'High', status: 'Open', date: 'Oct 03, 2026' },
  { id: 'WO-2022', title: 'Routine Filter Cleaning', location: 'Baramati WTP', assigned: 'Amit J.', priority: 'Low', status: 'Closed', date: 'Sep 28, 2026' },
];

export default function TicketsPage() {
  const [activeTab, setActiveTab] = useState('All');

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
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Location</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Assigned To</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Priority</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Status</th>
              <th style={{ padding: '16px 20px', color: '#718096', fontWeight: 500, fontSize: '13px' }}>Date</th>
              <th style={{ padding: '16px 20px' }}></th>
            </tr>
          </thead>
          <tbody>
            {mockTickets.map((t, i) => (
              <tr key={i} style={{ borderBottom: '1px solid var(--border-color)', backgroundColor: 'white' }}>
                <td style={{ padding: '16px 20px', fontWeight: 600, color: 'var(--primary-blue)' }}>{t.id}</td>
                <td style={{ padding: '16px 20px', fontWeight: 500 }}>{t.title}</td>
                <td style={{ padding: '16px 20px', color: '#4A5568' }}>{t.location}</td>
                <td style={{ padding: '16px 20px' }}>
                  <span style={{ 
                    display: 'inline-flex', alignItems: 'center', gap: '6px',
                    padding: '4px 10px', backgroundColor: t.assigned === 'Unassigned' ? '#FEEBC8' : '#EDF2F7',
                    borderRadius: '16px', fontSize: '12px', fontWeight: 500,
                    color: t.assigned === 'Unassigned' ? '#C05621' : '#4A5568'
                  }}>
                    {t.assigned}
                  </span>
                </td>
                <td style={{ padding: '16px 20px' }}>
                  <span style={{ color: t.priority === 'High' ? '#E53E3E' : t.priority === 'Medium' ? '#DD6B20' : '#38A169', fontWeight: 600, fontSize: '13px' }}>
                    {t.priority}
                  </span>
                </td>
                <td style={{ padding: '16px 20px' }}>
                  <span style={{ 
                    padding: '4px 10px', 
                    borderRadius: '4px', 
                    fontSize: '12px',
                    fontWeight: 600,
                    backgroundColor: t.status === 'Closed' ? '#E2E8F0' : t.status === 'Open' ? '#FED7D7' : '#BEE3F8',
                    color: t.status === 'Closed' ? '#4A5568' : t.status === 'Open' ? '#9B2C2C' : '#2B6CB0'
                  }}>
                    {t.status}
                  </span>
                </td>
                <td style={{ padding: '16px 20px', color: '#718096', fontSize: '13px' }}>{t.date}</td>
                <td style={{ padding: '16px 20px', color: '#A0AEC0', cursor: 'pointer' }}><MoreVertical size={18} /></td>
              </tr>
            ))}
          </tbody>
        </table>
        
        <div style={{ padding: '16px 20px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px solid var(--border-color)' }}>
          <span style={{ fontSize: '13px', color: '#718096' }}>Showing 1 to 4 of 4 entries</span>
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
