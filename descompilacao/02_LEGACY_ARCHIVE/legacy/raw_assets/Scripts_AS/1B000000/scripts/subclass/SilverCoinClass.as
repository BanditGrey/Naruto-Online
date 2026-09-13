package subclass
{
   import flash.display.MovieClip;
   
   public class SilverCoinClass
   {
      
      public static const three:int = 3;
      
      protected var FMC_Hundreds:MovieClip = null;
      
      protected var FMC_Tens:MovieClip = null;
      
      protected var FMC_Units:MovieClip = null;
      
      protected var FNumVec:Vector.<MovieClip>;
      
      public function SilverCoinClass(mc1:MovieClip, mc2:MovieClip, mc3:MovieClip)
      {
         super();
         this.FNumVec = new Vector.<MovieClip>(three);
         this.FMC_Hundreds = mc1;
         this.FMC_Tens = mc2;
         this.FMC_Units = mc3;
         this.FNumVec[0] = this.FMC_Units;
         this.FNumVec[1] = this.FMC_Tens;
         this.FNumVec[2] = this.FMC_Hundreds;
      }
      
      public function SetPictureByNum(num:int) : void
      {
         var Hundred:int = -1;
         var Ten:int = -1;
         var Unit:int = -1;
         var numStr:String = String(num);
         if(num >= 100)
         {
            Hundred = int(numStr.charAt(0));
            Ten = int(numStr.charAt(1));
            Unit = int(numStr.charAt(2));
         }
         else if(num >= 10)
         {
            Ten = int(numStr.charAt(0));
            Unit = int(numStr.charAt(1));
         }
         else
         {
            Unit = int(numStr);
         }
         if(Unit == -1)
         {
            this.FNumVec[0].visible = false;
         }
         else
         {
            this.FNumVec[0].gotoAndStop(Unit + 1);
            this.FNumVec[0].visible = true;
         }
         if(Ten == -1)
         {
            this.FNumVec[1].visible = false;
         }
         else
         {
            this.FNumVec[1].gotoAndStop(Ten + 1);
            this.FNumVec[1].visible = true;
         }
         if(Hundred == -1)
         {
            this.FNumVec[2].visible = false;
         }
         else
         {
            this.FNumVec[2].gotoAndStop(Hundred + 1);
            this.FNumVec[2].visible = true;
         }
      }
   }
}

