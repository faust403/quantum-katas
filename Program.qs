namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    @EntryPoint()
    operation Program() : Unit
    {
        let count = 1000;
        let state = Zero;
        Message($"{count_ones(count, state)}");
    }
    operation count_ones(count :Int, initial :Result) : (Int, Int)
    {
        use (q1, q2) = (Qubit(), Qubit());
        mutable res = 0;

        for i in 1..count
        {
            H(q1);
            H(q2);
            if M(q1) == One and M(q2) == One
            {
                set res += 1;
            }
        }
        set_state(q1, Zero);
        set_state(q2, Zero);
        return (count, res);
    }
    operation set_state(q :Qubit, state :Result) : Unit
    {
        if M(q) != state
        {
            X(q);
        }
    }
}
