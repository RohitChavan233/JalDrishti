'use client';

import { useEffect, useState } from 'react';

type Ticket = {
  id: string;
  issue: string;
  details: string;
  severity: string;
  status: string;
  time: string;
};

export default function AlertsList() {
  const [tickets, setTickets] = useState<Ticket[]>([]);

  const fetchTickets = async () => {
    try {
      const res = await fetch('/api/tickets');
      if (res.ok) {
        const data = await res.json();
        setTickets(data);
      }
    } catch (e) {
      console.error("Failed to fetch tickets", e);
    }
  };

  useEffect(() => {
    // Initial fetch
    fetchTickets();
    // Poll every 3 seconds to get live updates from the mobile app
    const interval = setInterval(fetchTickets, 3000);
    return () => clearInterval(interval);
  }, []);

  const getTimeAgo = (isoString: string) => {
    const diff = Math.floor((new Date().getTime() - new Date(isoString).getTime()) / 60000);
    if (diff < 1) return 'Just now';
    if (diff < 60) return `${diff} mins ago`;
    return `${Math.floor(diff / 60)} hrs ago`;
  };

  const getSeverityIcon = (severity: string) => {
    if (severity === 'critical') return '🧪';
    if (severity === 'high') return '🚨';
    return '💧';
  };

  return (
    <div className="alert-list">
      {tickets.map((ticket) => (
        <div key={ticket.id} className={`alert-item ${ticket.severity}-severity`}>
          <div className="alert-icon">{getSeverityIcon(ticket.severity)}</div>
          <div className="alert-details">
            <h4>{ticket.issue}</h4>
            <p>{ticket.details}</p>
            <span className="time">{getTimeAgo(ticket.time)}</span>
          </div>
          <div className="alert-status">{ticket.status}</div>
        </div>
      ))}
    </div>
  );
}
