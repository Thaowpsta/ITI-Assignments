class Complex{
    
    private double real;
    private double imag;
    
    public Complex(double r, double i){
        real = r;
        imag = i;
    }
    
    public Complex add(double r, double i){
        double sumReal = real + r;
        double sumImag = imag + i;
        
        return new Complex(sumReal, sumImag);
    }
    
    public Complex subtract(double r, double i){
        double subReal = Math.abs(real - r);
        double subImag = Math.abs(imag - i);
        
        return new Complex(subReal, subImag);
    }
    
    public String toString(){
        return real + " + " + imag + "i";
    }
}
