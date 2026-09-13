package Processors.Game.Lobby.TreasureMap
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class ConsumeFrame
   {
      
      protected var FDescribeString:String;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      public function ConsumeFrame(param1:uint)
      {
         super();
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,param1) as TSystemLanguage;
         this.FDescribeString = this.FSystemLanguage.Desc;
      }
      
      public function get DescribeString() : String
      {
         return this.FDescribeString;
      }
   }
}

