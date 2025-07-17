#!/bin/bash
# debug-streamlit.sh - Debug Streamlit connectivity issues

echo "🔍 Debugging Streamlit container connectivity..."

ssh -T personal_hetzner_cloud << 'EOF'
echo "=== Container Status ==="
docker ps | grep streamlit

echo ""
echo "=== Container Logs ==="
docker logs egle-streamlit-demo --tail 20

echo ""
echo "=== Test local connectivity ==="
curl -I http://localhost:8501 2>/dev/null && echo "✅ Local connection works" || echo "❌ Local connection failed"

echo ""
echo "=== Check if port is listening ==="
netstat -tlnp | grep :8501 || ss -tlnp | grep :8501

echo ""
echo "=== UFW Firewall Status ==="
ufw status

echo ""
echo "=== Iptables Rules ==="
iptables -L INPUT -n | grep 8501 || echo "No specific iptables rules for port 8501"

echo ""
echo "=== Test from inside container ==="
docker exec egle-streamlit-demo ps aux | grep streamlit
EOF

echo "🚀 Debug complete! Check output above for issues."
