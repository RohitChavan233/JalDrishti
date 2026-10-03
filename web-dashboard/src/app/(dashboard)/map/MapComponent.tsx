'use client';
import React, { useEffect, useState } from 'react';
import { MapContainer, TileLayer, Marker, Popup, Circle } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

// Fix leaflet default icons in nextjs
const icon = L.icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  tooltipAnchor: [16, -28],
  shadowSize: [41, 41]
});

const redIcon = L.icon({
  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41]
});

const orangeIcon = L.icon({
  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41]
});

export default function MapComponent() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) return <div style={{height: 600, background: '#E2E8F0', display: 'flex', alignItems: 'center', justifyContent: 'center'}}>Loading map...</div>;

  return (
    <MapContainer center={[18.5204, 73.8567]} zoom={10} style={{ height: '600px', width: '100%', borderRadius: '12px' }}>
      <TileLayer
        url="https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
      />
      
      {/* Normal FHTCs */}
      <Marker position={[18.5204, 73.8567]} icon={icon}>
        <Popup><b>Pune Central</b><br/>FHTCs: 4,200<br/>Status: Normal</Popup>
      </Marker>
      <Marker position={[18.6161, 73.7984]} icon={icon}>
        <Popup><b>Pimpri</b><br/>FHTCs: 3,100<br/>Status: Normal</Popup>
      </Marker>

      {/* Issues */}
      <Marker position={[18.8267, 74.3820]} icon={redIcon}>
        <Popup><b>Shirur GP</b><br/>Status: Pump Fault<br/>Water Supply: Offline</Popup>
      </Marker>
      <Circle center={[18.8267, 74.3820]} pathOptions={{ fillColor: 'red', color: 'red' }} radius={3000} />

      <Marker position={[18.1634, 73.8443]} icon={orangeIcon}>
        <Popup><b>Bhor GP</b><br/>Status: High Turbidity Warning</Popup>
      </Marker>
      <Circle center={[18.1634, 73.8443]} pathOptions={{ fillColor: 'orange', color: 'orange' }} radius={2000} />

      <Marker position={[18.8471, 73.8887]} icon={icon}>
        <Popup><b>Khed GP</b><br/>FHTCs: 1,800<br/>Status: Normal</Popup>
      </Marker>
      
    </MapContainer>
  );
}
