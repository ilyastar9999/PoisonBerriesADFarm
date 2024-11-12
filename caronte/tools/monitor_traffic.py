#!/usr/bin/env python3
import websockets
import asyncio
import json
import time

async def monitor_caronte():
    uri = "ws://localhost:3752/api/connections/stream"
    
    async with websockets.connect(uri) as websocket:
        print("Connected to Caronte websocket stream")
        
        while True:
            try:
                message = await websocket.recv()
                data = json.loads(message)
                
                # Process connection data
                process_connection(data)
                
            except websockets.exceptions.ConnectionClosed:
                print("Connection closed, attempting to reconnect...")
                await asyncio.sleep(5)
                continue

def process_connection(conn):
    timestamp = time.strftime('%Y-%m-%d %H:%M:%S', 
                            time.localtime(conn['timestamp']))
    
    print(f"\nNew Connection at {timestamp}")
    print(f"Source: {conn['src_ip']}:{conn['src_port']}")
    print(f"Destination: {conn['dst_ip']}:{conn['dst_port']}")
    
    if 'extracted_data' in conn:
        print("\nExtracted Data:")
        for data in conn['extracted_data']:
            print(f"Type: {data['type']}")
            print(f"Content: {data['content']}")
    
    print("-" * 50)

if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(monitor_caronte()) 