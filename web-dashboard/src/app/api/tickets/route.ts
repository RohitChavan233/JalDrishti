import { NextResponse } from 'next/server';

// In-memory store (will reset when Next.js server restarts)
// We declare it outside the handler to keep state across requests in dev mode
let tickets = [
  {
    id: "TKT-INIT-1",
    issue: "Pump Fault Detected",
    details: "Shirur GP • Motor current zero during schedule",
    severity: "high",
    status: "Escalated",
    time: new Date(Date.now() - 10 * 60000).toISOString()
  },
  {
    id: "TKT-INIT-2",
    issue: "Water Quality Breach",
    details: "Bhor GP • Turbidity exceeds 5 NTU at ESR",
    severity: "critical",
    status: "Advisory Sent",
    time: new Date(Date.now() - 22 * 60000).toISOString()
  }
];

export async function GET() {
  return NextResponse.json(tickets);
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
    
    // Add to the top of the list
    tickets.unshift(newTicket);
    
    return NextResponse.json({ success: true, ticket: newTicket });
  } catch (error) {
    return NextResponse.json({ success: false, error: "Failed to process request" }, { status: 400 });
  }
}
