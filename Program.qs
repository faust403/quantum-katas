namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation Program() : Result
    {
        use q = Qubit();
        set_state(q, One);
        set_state(q, Zero);
        return M(q);
    }
    operation set_state(target :Qubit, state :Result) : Unit
    {
        if M(target) != state
        {
            X(target);
        }
    }
    @EntryPoint()
    operation test_bell_state(count :Int, initial :Result) : (Int, Int, Int, Int)
    {
        mutable numOnesQ1 = 0;
        mutable numOnesQ2 = 0;

        //allocate the qubits
        use (q1, q2) = (Qubit(), Qubit());
        for test in 1..count
        {
            H(q1);
            H(q2);
            CNOT(q1, q2); // if q1 == One then q2 reversing

            //Measure each qubit
            let resultQ1 = M(q1);
            let resultQ2 = M(q2);

            //Count the county of "one's"
            if resultQ1 == One
            {
                set numOnesQ1 += 1;
            }
            if resultQ2 == One
            {
                set numOnesQ2 += 1;
            }
        }
        //reset the qubits
        set_state(q1, Zero);
        set_state(q2, Zero);

        //Return times we saw |0>, times we saw |1>
        Message("q1:Zero, One q2:Zero, One");
        return (count - numOnesQ1, numOnesQ1, count - numOnesQ2, numOnesQ2);
    }
    //M - measurement; X - reverse state of qubit
}
