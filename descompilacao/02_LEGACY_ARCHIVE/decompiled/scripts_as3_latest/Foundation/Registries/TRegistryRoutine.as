package Foundation.Registries
{
   public class TRegistryRoutine
   {
      
      protected var FIdentifiers:Vector.<uint>;
      
      protected var FRoutines:Vector.<Function>;
      
      public function TRegistryRoutine()
      {
         super();
         this.FIdentifiers = new Vector.<uint>();
         this.FRoutines = new Vector.<Function>();
      }
      
      public function Register(param1:uint, param2:Function) : void
      {
         this.FIdentifiers.push(param1);
         this.FRoutines.push(param2);
      }
      
      public function GetRoutineByIndex(param1:int) : Function
      {
         return this.FRoutines[param1];
      }
      
      public function GetRoutineByIndentifier(param1:uint) : Function
      {
         var _loc2_:int = this.FIdentifiers.indexOf(param1);
         if(_loc2_ >= 0)
         {
            return this.FRoutines[_loc2_];
         }
         return null;
      }
      
      public function get Count() : int
      {
         return this.FIdentifiers.length;
      }
   }
}

