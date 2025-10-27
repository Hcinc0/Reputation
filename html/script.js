// NUI Message Handler
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.type) {
        case 'toggle':
            toggleUI(data.show);
            break;
        
        case 'update':
            updateTrustFactor(data);
            break;
        
        case 'flash':
            flashEffect(data.color);
            break;
    }
});

// Toggle UI visibility
function toggleUI(show) {
    const container = document.getElementById('reputationContainer');
    
    if (show) {
        container.classList.add('show');
    } else {
        container.classList.remove('show');
    }
}

// Update trust factor display
function updateTrustFactor(data) {
    const trustValue = document.getElementById('trustValue');
    const levelName = document.getElementById('levelName');
    const progressFill = document.getElementById('progressFill');
    const container = document.getElementById('reputationContainer');
    
    // Update values
    trustValue.textContent = data.trustFactor;
    levelName.textContent = data.levelName;
    
    // Update progress bar
    progressFill.style.width = data.progress + '%';
    
    // Update level class for styling
    const levelClass = 'level-' + data.levelName.toLowerCase().replace(/\s+/g, '-');
    
    // Remove all level classes
    container.className = 'container';
    
    // Add new level class
    container.classList.add(levelClass);
    
    // Update level name color
    levelName.style.color = data.levelColor;
}

// Flash effect for trust factor changes
function flashEffect(color) {
    const container = document.getElementById('reputationContainer');
    
    // Add flash class
    container.classList.add('flash');
    
    // Remove flash class after animation
    setTimeout(() => {
        container.classList.remove('flash');
    }, 500);
}

// Request UI close
function closeUI() {
    fetch('https://reputation/closeUI', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

console.log('Reputation UI loaded successfully');
