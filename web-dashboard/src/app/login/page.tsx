'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const router = useRouter();
  const [mobile, setMobile] = useState('');
  const [otp, setOtp] = useState('');
  const [step, setStep] = useState(1);
  const [loading, setLoading] = useState(false);

  const handleSendOtp = (e: React.FormEvent) => {
    e.preventDefault();
    if (mobile.length >= 10) {
      setLoading(true);
      setTimeout(() => {
        setLoading(false);
        setStep(2);
      }, 800);
    }
  };

  const handleVerify = (e: React.FormEvent) => {
    e.preventDefault();
    if (otp.length >= 4) {
      setLoading(true);
      setTimeout(() => {
        router.push('/');
      }, 1000);
    }
  };

  return (
    <div className="login-container">
      <div className="login-card fade-in">
        <div className="login-header">
          <div className="logo-icon-large"></div>
          <h1>JalDrishti</h1>
          <p>Real-Time FHTC Monitoring Platform</p>
        </div>

        {step === 1 ? (
          <form onSubmit={handleSendOtp} className="login-form">
            <div className="input-group">
              <label>Mobile Number or Email</label>
              <input 
                type="text" 
                placeholder="Enter your registered mobile or email" 
                value={mobile}
                onChange={(e) => setMobile(e.target.value)}
                required
              />
            </div>
            <button type="submit" className="login-btn" disabled={loading}>
              {loading ? 'Sending OTP...' : 'Login with OTP'}
            </button>
          </form>
        ) : (
          <form onSubmit={handleVerify} className="login-form">
            <div className="input-group">
              <label>Enter OTP</label>
              <input 
                type="text" 
                placeholder="Enter 4-digit OTP" 
                maxLength={4}
                value={otp}
                onChange={(e) => setOtp(e.target.value)}
                required
              />
              <span className="helper-text">OTP sent to {mobile}</span>
            </div>
            <button type="submit" className="login-btn" disabled={loading}>
              {loading ? 'Verifying...' : 'Verify & Enter'}
            </button>
            <button type="button" className="btn-text mt-4" onClick={() => setStep(1)}>
              Back
            </button>
          </form>
        )}
      </div>

      <style jsx>{`
        .login-container {
          height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
          background: linear-gradient(135deg, var(--primary-blue), var(--secondary-teal));
        }

        .login-card {
          background: white;
          padding: 48px;
          border-radius: 16px;
          box-shadow: 0 20px 40px rgba(0,0,0,0.2);
          width: 100%;
          max-width: 440px;
        }

        .login-header {
          text-align: center;
          margin-bottom: 32px;
        }

        .logo-icon-large {
          width: 64px;
          height: 64px;
          background: linear-gradient(135deg, var(--accent-teal), #4FD1C5);
          border-radius: 16px;
          margin: 0 auto 16px;
          box-shadow: 0 8px 16px rgba(0,163,180,0.2);
        }

        .login-header h1 {
          font-size: 28px;
          color: var(--primary-blue);
          margin-bottom: 8px;
        }

        .login-header p {
          color: var(--text-muted);
          font-size: 14px;
        }

        .login-form {
          display: flex;
          flex-direction: column;
          gap: 20px;
        }

        .input-group {
          display: flex;
          flex-direction: column;
          gap: 8px;
        }

        .input-group label {
          font-size: 14px;
          font-weight: 600;
          color: var(--text-main);
        }

        .input-group input {
          padding: 12px 16px;
          border: 1px solid var(--border-color);
          border-radius: 8px;
          font-size: 16px;
          outline: none;
          transition: border-color 0.2s;
        }

        .input-group input:focus {
          border-color: var(--secondary-teal);
        }

        .helper-text {
          font-size: 12px;
          color: var(--text-muted);
          margin-top: 4px;
        }

        .login-btn {
          background: var(--primary-blue);
          color: white;
          border: none;
          padding: 14px;
          border-radius: 8px;
          font-size: 16px;
          font-weight: 600;
          cursor: pointer;
          transition: background 0.2s, transform 0.1s;
        }

        .login-btn:hover:not(:disabled) {
          background: var(--secondary-teal);
        }

        .login-btn:active:not(:disabled) {
          transform: scale(0.98);
        }

        .login-btn:disabled {
          opacity: 0.7;
          cursor: not-allowed;
        }

        .btn-text {
          background: none;
          border: none;
          color: var(--text-muted);
          cursor: pointer;
          font-weight: 500;
        }
        
        .mt-4 {
          margin-top: 16px;
        }
      `}</style>
    </div>
  );
}
