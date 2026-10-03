import { NextResponse } from 'next/server';
import fs from 'fs';
import path from 'path';

export const dynamic = 'force-dynamic';

const dbPath = path.join(process.cwd(), 'db.json');

// Initialize DB if it doesn't exist
if (!fs.existsSync(dbPath)) {
  const initialTickets = [
    {
      id: "TKT-INIT-1",
      issue: "Pump Fault Detected",
      details: "Shirur GP • Motor current zero during schedule",
      severity: "high",
      status: "Escalated",
      time: new Date(Date.now() - 10 * 60000).toISOString()
    }
  ];
  fs.writeFileSync(dbPath, JSON.stringify(initialTickets, null, 2));
}

function getTickets() {
  const data = fs.readFileSync(dbPath, 'utf8');
  return JSON.parse(data);
}

function saveTickets(tickets: any[]) {
  fs.writeFileSync(dbPath, JSON.stringify(tickets, null, 2));
}

export async function GET() {
  return NextResponse.json(getTickets());
}

export async function POST(request: Request) {
  try {
    const data = await request.json();
    
    const newTicket = {
      id: data.id || `TKT-${Math.floor(Math.random() * 10000)}`,
      issue: data.issue || "Citizen Reported Issue",
      details: data.details || "Citizen App Report • Location Auto-detected",
      severity: "medium", 
      status: "Investigating",
      time: new Date().toISOString()
    };
    
    const tickets = getTickets();
    tickets.unshift(newTicket);
    saveTickets(tickets);
    
    return NextResponse.json({ success: true, ticket: newTicket });
  } catch (error) {
    return NextResponse.json({ success: false, error: "Failed to process request" }, { status: 400 });
  }
}
