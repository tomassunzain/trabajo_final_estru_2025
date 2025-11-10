using System;
using System.Linq;

class Program {
    static double Mean(double[] a) => a.Average();
    static double Std(double[] a) {
        double m = Mean(a);
        return Math.Sqrt(a.Sum(x => Math.Pow(x - m, 2)) / (a.Length - 1));
    }
    static double Cov(double[] x, double[] y) {
        double mx = Mean(x), my = Mean(y);
        double s = 0;
        for(int i=0;i<x.Length;i++) s += (x[i]-mx)*(y[i]-my);
        return s / (x.Length - 1);
    }
    static double Corr(double[] x, double[] y) => Cov(x,y)/(Std(x)*Std(y));

    static void Main() {
        double[] UnitPrice={74.69,15.28,46.33,58.22,33.08};
        double[] Quantity={7,5,3,8,4};
        double[] Total={516.83,76.40,138.99,465.76,132.32};
        var names = new[]{ "UnitPrice","Quantity","Total"};
        var data = new[]{ UnitPrice,Quantity,Total };

        Console.WriteLine("Manual correlation matrix:");
        for(int i=0;i<3;i++){
            Console.Write(names[i]+": ");
            for(int j=0;j<3;j++)
                Console.Write($"{Corr(data[i],data[j]):0.####} ");
            Console.WriteLine();
        }

        // --- Integrada (using MathNet.Numerics) ---
        // if library available:
        // var matrix = Correlation.PearsonMatrix(DenseMatrix.OfRows(3,5,data));
    }
}
