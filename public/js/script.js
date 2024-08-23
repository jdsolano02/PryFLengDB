document.getElementById('fetchData').addEventListener('click', () => {
    fetch('/data')
      .then(response => response.json())
      .then(data => {
        document.getElementById('data').textContent = JSON.stringify(data);
      })
      .catch(error => console.error('Error:', error));
  });
  