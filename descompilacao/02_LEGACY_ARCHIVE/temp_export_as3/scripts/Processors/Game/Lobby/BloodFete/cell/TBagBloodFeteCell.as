package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteSingle;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TBagBloodFeteCell extends Sprite
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FBloodFeteSingle:TBloodFeteSingle = null;
      
      protected var FName:TextField = null;
      
      protected var FLevel:TextField = null;
      
      protected var FMC_Effect:MovieClip = null;
      
      protected var FBmp:Bitmap = null;
      
      public function TBagBloodFeteCell(param1:TBloodFeteSingle = null)
      {
         super();
         this.FBloodFeteSingle = param1;
         this.LoadFla();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      protected function LoadFla() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODFETE.MC_BloodFeteSingle) as MovieClip;
         this.addChild(this.FThisPanel);
         this.FName = this.FThisPanel["MC_Name"];
         this.FLevel = this.FThisPanel["Mc_Level"];
         this.FMC_Effect = this.FThisPanel["MC_Effect"];
         this.FBmp = new Bitmap();
         this.FMC_Effect.addChild(this.FBmp);
      }
      
      public function set BloodFeteSingle(param1:TBloodFeteSingle) : void
      {
         this.FBloodFeteSingle = param1;
         this.UpdateDate();
      }
      
      public function get BloodFeteSingle() : TBloodFeteSingle
      {
         return this.FBloodFeteSingle;
      }
      
      public function UpdateDate() : void
      {
         if(this.FBloodFeteSingle == null)
         {
            this.rest();
            return;
         }
         this.FName.text = String(this.FBloodFeteSingle.Name);
         this.FLevel.text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Name_Real_Level,this.FBloodFeteSingle.Level);
         if(this.FBloodFeteSingle.Type == 3)
         {
            this.FName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[6];
            this.FLevel.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[6];
         }
         else
         {
            this.FName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FBloodFeteSingle.Quality];
            this.FLevel.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FBloodFeteSingle.Quality];
         }
      }
      
      public function rest() : void
      {
         this.FName.text = "";
         this.FLevel.text = "";
      }
      
      public function UpdateImage() : void
      {
         if(this.FBloodFeteSingle == null)
         {
            return;
         }
         TGameUtil.ShowAnimationByID(TGameUtil.Type_FollowBloodBound,this.FBmp,CONST_MODULES.MODULE_BloodFete,this.FBloodFeteSingle.EffectId);
      }
   }
}

