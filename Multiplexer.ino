const int OutputPins[3] = {10, 9, 8}; // S0~10, S1~9, S2~8
const int InputPins[3] = {13, 12, 11}; // S0~13, S1~12, S2~11
const int zOutput = 5; // Connect common (Z) to 5 (PWM-capable)
const int zInput = A0; // Connect common (Z) to A0 (analog input)

void setup() {
  Serial.begin(9600);
  for (int i=0; i<3; i++)
  {
    pinMode(OutputPins[i], OUTPUT);
    digitalWrite(OutputPins[i], LOW);
  }
  pinMode(zOutput, OUTPUT); // Set up Z as an output

  for (int i=0; i<3; i++)
  {
    pinMode(InputPins[i], OUTPUT);
    digitalWrite(InputPins[i], HIGH);
  }
  pinMode(zInput, INPUT); // Set up Z as an input

  // Print the header:
  Serial.println("1.\t2.\t3.\t4.\t5.\t6.\t7.\t8.\t9.\t10.\t11.\t12.\t13.\t14.\t15.\t16.\t17.\t18.\t19.\t20.\t21.\t22.\t23.\t24.\t25.\t26.\t27.\t28.\t29.\t30.\t31.\t32.\t33.\t34.\t35.\t36.\t37.\t38.\t39.\t40.\t41.\t42.\t43.\t44.\t45.\t46.\t47.\t48.\t49.\t50.\t51.\t52.\t53.\t54.\t55.\t56.\t57.\t58.\t59.\t60.\t61.\t62.\t63.\t64.");
  Serial.println("---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---");
}

void loop() {
  for (byte pin=0; pin<=7; pin++) 
  { 
    for (int i=0; i<3; i++)
    {
      if (pin & (1<<i))
        digitalWrite(OutputPins[i], HIGH);
      else
        digitalWrite(OutputPins[i], LOW);
    }
    
    analogWrite(zOutput, 255);

    for (byte pin2=0; pin2<=7; pin2++) {
      for (int j=0; j<3; j++)
      {
        if (pin2 & (1<<j))
          digitalWrite(InputPins[j], HIGH);
        else
          digitalWrite(InputPins[j], LOW);
      }
      int inputValue = analogRead(A0);
      Serial.print(String(inputValue) + "\t");
    }
  }
  Serial.println();
}
