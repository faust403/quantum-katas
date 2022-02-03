namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;


    //Generator of random numbers, based on quantum phenomena
    @EntryPoint()
    operation Program() : Unit
    {
        mutable from = 90;
        mutable to = 100;
        for _ in 1..10
        {
            Message($"{random_num(from, to)}");
	    }
    }
    operation random_num(from :Int, to :Int) :Int
    {
        mutable ress = 0;
        repeat
        {
            mutable res = new Result[0];
            for _ in 1..BitSizeI(to)
            {
                set res += [random_res()];
            }
            set ress = ResultArrayAsInt(res);
        }
        until ress <= to and ress >= from;
        return ress;
    }
    operation random_res() : Result
    {
        use q = Qubit();
        H(q);
        return M(q);
    }
    operation set_state(q :Qubit, state :Result) : Unit
    {
        if M(q) != state
        {
            X(q);
        }
    }
}
