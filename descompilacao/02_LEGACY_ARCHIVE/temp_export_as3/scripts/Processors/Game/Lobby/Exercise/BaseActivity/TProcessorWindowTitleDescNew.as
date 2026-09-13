package Processors.Game.Lobby.Exercise.BaseActivity
{
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TAddValue;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TITLE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTitleDescNew extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 426;
      
      protected static const SIZE_Window_Height:uint = 299;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FTitleID:uint;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_GetDetail:TextField;
      
      protected var FTF_PropertyDetail:TextField;
      
      protected var FMC_TitleEffect:Sprite;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FEndTime:uint;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      public function TProcessorWindowTitleDescNew(param1:TUIComponent)
      {
         super(param1);
         this.FTitleBmp = new Bitmap();
         this.FAllTitles = new TTitles();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137121);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Bitmap = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_BaseActiveTitle") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Time = this.FMC_Scene["TF_Time"];
         this.FTF_GetDetail = this.FMC_Scene["TF_GetDetail"];
         this.FTF_PropertyDetail = this.FMC_Scene["TF_PropertyDetail"];
         this.FMC_TitleEffect = this.FMC_Scene["MC_TitleEffect"];
         this.FMC_TitleEffect.addChild(this.FTitleBmp);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:int = 0;
         if(!this.Visible)
         {
            return;
         }
         if(this.FEndTime != 0)
         {
            this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_RestTime,TGameUtil.fomatTime(this.FEndTime - STimingCore.GetServerTick()));
         }
         this.UpdateTitleEffect();
         super.LogicsPerform();
      }
      
      protected function UpdateTitleEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FTitleID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,CONST_MODULES.ACTIVE_Test,this.FTitleID);
            this.FMC_TitleEffect.x = 25 + (210 - this.FMC_TitleEffect.width) / 2;
            this.FMC_TitleEffect.y = 80 + (143 - this.FMC_TitleEffect.height) / 2;
         }
         else
         {
            this.FTitleBmp.bitmapData = null;
         }
      }
      
      protected function UpdateInfo() : void
      {
         var _loc1_:TTitle = null;
         var _loc2_:Vector.<uint> = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TAddValue = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         _loc1_ = this.FAllTitles.GetTitleByIdentifier(this.FTitleID);
         if(_loc1_ != null)
         {
            _loc3_ = "";
            _loc5_ = _loc1_.AddValues.length;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = _loc1_.AddValues[_loc4_];
               _loc7_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc6_.AddType);
               if(_loc7_ > -1)
               {
                  if(_loc6_.AddValue >= 1)
                  {
                     _loc3_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc7_] + "+" + _loc6_.AddValue + "\n";
                  }
                  else
                  {
                     _loc3_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc7_] + "+" + _loc6_.AddValue * 100 + "%\n";
                  }
               }
               _loc4_++;
            }
            if(_loc3_ == "")
            {
               this.FTF_PropertyDetail.text = STRING_TITLE.STRING_Nothing;
            }
            else
            {
               this.FTF_PropertyDetail.text = _loc3_;
            }
            _loc8_ = _loc1_.TitleSource;
            _loc8_ = _loc8_.split("%n").join("\n");
            this.FTF_GetDetail.text = _loc8_;
            this.FEndTime = _loc1_.EndTime;
            _loc2_ = _loc1_.LastTime;
            if(this.FEndTime != 0)
            {
               this.FTF_Time.visible = true;
            }
            else
            {
               this.FTF_Time.visible = _loc1_.Type != 0;
               if(_loc1_.Type == 1)
               {
                  this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_TitleLastTime,_loc2_[0],_loc2_[1]);
               }
               else if(_loc1_.Type == 2)
               {
                  this.FTF_Time.text = STRING_TITLE.STRING_Forever;
               }
               else if(_loc1_.Type == 3)
               {
                  this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_EndTime,_loc2_[0],_loc2_[1],_loc2_[2]);
               }
            }
         }
         else
         {
            this.FTF_GetDetail.text = "";
            this.FTF_PropertyDetail.text = "";
            this.FTitleID = 0;
            this.FTF_Time.text = "";
            this.FEndTime = 0;
         }
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(10);
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function UpdateUI(param1:uint) : void
      {
         this.FTitleID = param1;
         this.UpdateInfo();
      }
   }
}

