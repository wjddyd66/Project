// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["Road(자전거도로)", "Popular(명소)", "Park(공원)", "River(강,하천)", "people(유동인구)", "Univ(대학교)"],
    datasets: [{
      data: [12.21, 15.58, 11.25, 17, 57, 52],
      backgroundColor: ['yellow', '#dc3545', 'green', 'blue', 'navy', 'purple'],
    }],
  },
});
