'use client';
import React, { useState } from 'react';
import { Settings, Users, Bell, Database, Shield, Smartphone } from 'lucide-react';

export default function SettingsPage() {
  const [activeTab, setActiveTab] = useState('General');

  const tabs = [
    { name: 'General', icon: <Settings size={18} /> },
    { name: 'Users & Roles', icon: <Users size={18} /> },
    { name: 'Notifications', icon: <Bell size={18} /> },
    { name: 'Telemetry Sync', icon: <Database size={18} /> },
    { name: 'Security', icon: <Shield size={18} /> },
    { name: 'Mobile App', icon: <Smartphone size={18} /> }
  ];

  return (
    <div className="dashboard-container fade-in">
      <header className="page-header flex justify-between items-center" style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '32px' }}>
        <div>
          <h1>System Settings</h1>
          <p>Configure dashboard preferences, users, and IoT parameters</p>
        </div>
        <button className="login-btn" style={{ padding: '10px 24px' }}>Save Changes</button>
      </header>

      <div style={{ display: 'flex', gap: '32px' }}>
        {/* Sidebar Nav */}
        <div style={{ width: '250px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
          {tabs.map(tab => (
            <button
              key={tab.name}
              onClick={() => setActiveTab(tab.name)}
              style={{
                display: 'flex', alignItems: 'center', gap: '12px',
                padding: '12px 16px', borderRadius: '8px', border: 'none', cursor: 'pointer',
                textAlign: 'left', fontSize: '14px', fontWeight: 500,
                backgroundColor: activeTab === tab.name ? 'var(--primary-blue)' : 'transparent',
                color: activeTab === tab.name ? 'white' : '#4A5568',
                transition: 'all 0.2s'
              }}
            >
              {tab.icon} {tab.name}
            </button>
          ))}
        </div>

        {/* Content Area */}
        <div style={{ flex: 1 }}>
          <div className="kpi-card" style={{ padding: '32px', minHeight: '500px' }}>
            <h2 style={{ fontSize: '18px', color: 'var(--primary-blue)', marginBottom: '24px', borderBottom: '1px solid var(--border-color)', paddingBottom: '16px' }}>
              {activeTab} Settings
            </h2>
            
            {activeTab === 'General' && (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '24px', maxWidth: '600px' }}>
                <div>
                  <label style={{ display: 'block', marginBottom: '8px', fontWeight: 500, fontSize: '14px' }}>District / Block Name</label>
                  <input type="text" defaultValue="Pune District" style={{ width: '100%', padding: '10px 12px', borderRadius: '6px', border: '1px solid var(--border-color)' }} />
                </div>
                <div>
                  <label style={{ display: 'block', marginBottom: '8px', fontWeight: 500, fontSize: '14px' }}>Language</label>
                  <select style={{ width: '100%', padding: '10px 12px', borderRadius: '6px', border: '1px solid var(--border-color)' }}>
                    <option>English</option>
                    <option>Marathi</option>
                    <option>Hindi</option>
                  </select>
                </div>
                <div>
                  <label style={{ display: 'block', marginBottom: '8px', fontWeight: 500, fontSize: '14px' }}>Default Map Coordinates (Lat, Lng)</label>
                  <div style={{ display: 'flex', gap: '12px' }}>
                    <input type="text" defaultValue="18.5204" style={{ flex: 1, padding: '10px 12px', borderRadius: '6px', border: '1px solid var(--border-color)' }} />
                    <input type="text" defaultValue="73.8567" style={{ flex: 1, padding: '10px 12px', borderRadius: '6px', border: '1px solid var(--border-color)' }} />
                  </div>
                </div>
              </div>
            )}

            {activeTab === 'Notifications' && (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
                {[
                  { title: 'Critical IoT Sensor Alerts', desc: 'Pump failure, dry run, severe contamination' },
                  { title: 'Citizen Grievances', desc: 'New tickets opened via Citizen App' },
                  { title: 'Daily Summary Reports', desc: 'Automated email sent at 8:00 AM daily' }
                ].map((item, i) => (
                  <div key={i} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', border: '1px solid var(--border-color)', borderRadius: '8px' }}>
                    <div>
                      <h4 style={{ margin: '0 0 4px 0', fontSize: '15px' }}>{item.title}</h4>
                      <p style={{ margin: 0, color: '#718096', fontSize: '13px' }}>{item.desc}</p>
                    </div>
                    {/* Toggle Switch */}
                    <div style={{ width: 44, height: 24, backgroundColor: 'var(--primary-blue)', borderRadius: '12px', position: 'relative', cursor: 'pointer' }}>
                      <div style={{ width: 20, height: 20, backgroundColor: 'white', borderRadius: '50%', position: 'absolute', top: 2, right: 2 }}></div>
                    </div>
                  </div>
                ))}
              </div>
            )}
            
            {activeTab !== 'General' && activeTab !== 'Notifications' && (
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '300px', color: '#A0AEC0' }}>
                Configuration module for {activeTab} is ready for integration.
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
