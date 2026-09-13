package Processors.Game.Lobby.TreasureMap
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class ConsumeFrameCopy
   {
      
      protected var FDescribeString:String;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      public function ConsumeFrameCopy(param1:uint)
      {
         super();
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,param1) as TSystemLanguage;
         if(this.FSystemLanguage)
         {
            this.FDescribeString = this.FSystemLanguage.Desc;
         }
         else
         {
            this.FDescribeString = "";
         }
      }
      
      public function get DescribeString() : String
      {
         var _loc1_:String = "";
         _loc1_ = this.FDescribeString.replace(/%L/g,"<");
         _loc1_ = _loc1_.replace(/%R/g,">");
         return _loc1_.replace(/%X/g,"/");
      }
   }
}

