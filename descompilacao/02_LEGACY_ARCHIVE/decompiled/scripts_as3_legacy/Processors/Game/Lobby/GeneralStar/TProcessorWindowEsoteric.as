package Processors.Game.Lobby.GeneralStar
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TStarMap;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.GeneralStar.TEsotericPoint;
   import Logics.GeneralStar.TEsotericPoints;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.GeneralStar.PackageStarPoint.TUIMiddleBackground;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GENERAL_STAR;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_GENERAL;
   import Resources.Strings.STRING_TAVERN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TProcessorWindowEsoteric extends TProcessorLobbyWindow
   {
      
      protected static const ColorDescription:Vector.<String> = STRING_TAVERN.ColorDescription;
      
      protected var POINT_COUNT:Vector.<int>;
      
      protected var SEAL_COUNT:Vector.<int>;
      
      protected var WORD_COUNT:Vector.<int>;
      
      protected var FGeneralStarMC:MovieClip;
      
      protected var FReelLeft:MovieClip;
      
      protected var FReelRight:MovieClip;
      
      protected var FCloseButton:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurrentPage:int;
      
      protected var FTotalQuantity:int;
      
      protected var FSevenStar:SimpleButton;
      
      protected var FMaskBtn:MovieClip;
      
      protected var FTimerID:uint;
      
      protected var FOpenLevel:uint;
      
      protected var FEsotericMC:Sprite;
      
      protected var FEsotericText:TextField;
      
      protected var FMC_AwakenSoul:Sprite;
      
      protected var FAwakenSoulText:TextField;
      
      protected var FReelNameBox:Sprite;
      
      protected var FReelName:TextField;
      
      protected var FMC_Left:MovieClip;
      
      protected var FMC_Right:MovieClip;
      
      protected var FSevenStarTip:TextField;
      
      protected var FHelpTips:THint;
      
      protected var FMiddleBackgrounds:Vector.<TUIMiddleBackground>;
      
      protected var FCharacter:TCharacter;
      
      protected var FEsotericPoints:TEsotericPoints;
      
      protected var FPageIndex:uint;
      
      protected var FMapIndex:uint;
      
      protected var FStarPointBin:TBins;
      
      protected var FStarMapBin:TBins;
      
      protected var FIsInit:Boolean;
      
      protected var FEsoterics:Vector.<TEsotericPoints>;
      
      protected var FTFGotoUndertown:TextField;
      
      protected var FOnHelpTipsOver:Function;
      
      protected var FOnHelpTipsOut:Function;
      
      protected var FOnPointMove:Function;
      
      protected var FOnPointOut:Function;
      
      protected var FOnPointClick:Function;
      
      protected var FOnSetQuality:Function;
      
      protected var FOnActivityBigDipper:Function;
      
      protected var FOnTiaoZhuanClick:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TProcessorWindowEsoteric(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FHelpTips = new THint();
         this.FCharacter = SLogicsCore.Character;
         this.FEsotericPoints = this.FCharacter.EsotericPoints;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GENERAL_STAR.RESOURCESID_GENERAL_STAR);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:MovieClip = null;
         var _loc9_:TUIMiddleBackground = null;
         var _loc10_:String = null;
         super.ResourcesPerform_UIDispatch();
         this.FGeneralStarMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_GENERAL_STAR.RESOURCESID_CLASSNAME_GENERAL_STAR) as MovieClip;
         addChild(this.FGeneralStarMC);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         this.FOpenLevel = _loc1_.Value as uint;
         if(SLogicsCore.Character.GetConfigValueById(91000004))
         {
            this.POINT_COUNT = CONST_GENERAL_STAR.PointCountCopy;
            this.SEAL_COUNT = CONST_GENERAL_STAR.SealCountCopy;
            this.WORD_COUNT = CONST_GENERAL_STAR.WordCountCopy;
            _loc6_ = 7;
         }
         else
         {
            this.POINT_COUNT = CONST_GENERAL_STAR.PointCount;
            this.SEAL_COUNT = CONST_GENERAL_STAR.SealCount;
            this.WORD_COUNT = CONST_GENERAL_STAR.WordCount;
            _loc6_ = 4;
         }
         this.FMiddleBackgrounds = new Vector.<TUIMiddleBackground>(this.POINT_COUNT.length);
         this.FEsoterics = new Vector.<TEsotericPoints>(this.POINT_COUNT.length);
         this.FSevenStar = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCESID_NAME_SevenStar];
         this.FMaskBtn = this.FGeneralStarMC[CONST_GENERAL_STAR.Mask_Btn];
         this.FSevenStarTip = new TextField();
         this.FSevenStarTip.autoSize = TextFieldAutoSize.LEFT;
         this.FSevenStarTip.multiline = true;
         this.FSevenStarTip.wordWrap = true;
         this.FSevenStarTip.x = this.FSevenStar.x + 10;
         this.FSevenStarTip.y = this.FSevenStar.y + 50;
         this.FSevenStarTip.mouseEnabled = false;
         this.FSevenStarTip.width = 80;
         _loc10_ = STRING_GENERAL.FORMAT_OpenBigDipper;
         _loc10_ = _loc10_.split("%0").join(this.FOpenLevel);
         this.FSevenStarTip.text = _loc10_;
         this.FSevenStarTip.textColor = 16750848;
         this.FSevenStarTip.filters = [new GlowFilter(0,1,2,2,5)];
         addChild(this.FSevenStarTip);
         this.FReelLeft = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCESID_NAME_ReelLeft];
         this.FUIPage.ButtonPrevious.Substrate = this.FReelLeft;
         this.FReelRight = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCESID_NAME_ReelRight];
         this.FUIPage.ButtonNext.Substrate = this.FReelRight;
         this.FUIPage.PageSize = 1;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.OnChangePage;
         this.FCloseButton = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCESID_NAME_Close];
         this.FBtn_Help = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCE_Link_Btn_Help];
         this.FReelNameBox = this.FGeneralStarMC[CONST_GENERAL_STAR.RESPIRCESID_MC_REELNAMEBOX];
         this.FReelName = this.FReelNameBox[CONST_GENERAL_STAR.RESPIRCESID_MC_REELNAME];
         this.FEsotericMC = this.FGeneralStarMC[CONST_GENERAL_STAR.RESPIRCESID_MC_SoulsBox];
         this.FEsotericText = this.FEsotericMC[CONST_GENERAL_STAR.RESPIRCESID_MC_Souls];
         this.FMC_AwakenSoul = this.FGeneralStarMC["MC_AwakenSoul"];
         this.FAwakenSoulText = this.FMC_AwakenSoul["TF_Point"];
         _loc4_ = this.FGeneralStarMC[CONST_GENERAL_STAR.RESPIRCESID_MC_Middle];
         _loc5_ = _loc4_[CONST_GENERAL_STAR.RESPIRCESID_MC_Reels];
         _loc3_ = this.POINT_COUNT.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_loc6_ == _loc2_)
            {
               _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + 4];
               _loc8_.visible = false;
               _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + 5];
               _loc8_.visible = false;
               _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + 6];
               _loc8_.visible = false;
               _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + 7];
            }
            else
            {
               if(_loc2_ + 1 == _loc3_ && _loc6_ == 7)
               {
                  _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + 7];
                  _loc8_.visible = false;
               }
               _loc8_ = _loc5_[CONST_GENERAL_STAR.RESOURCESID_REEL + _loc2_];
            }
            _loc7_ = uint(this.POINT_COUNT[_loc2_]);
            _loc9_ = new TUIMiddleBackground(this);
            _loc9_.OnGeneralStarMove = this.FOnPointMove;
            _loc9_.OnGeneralStarOut = this.FOnPointOut;
            _loc9_.OnGeneralStarClick = this.FOnPointClick;
            _loc9_.OnClickTiaoZhuan = this.OnTiaoZhuanClickC;
            _loc9_.OnSetColour = this.SetColour;
            _loc9_.init(_loc8_,_loc7_,this.SEAL_COUNT[_loc2_],this.WORD_COUNT[_loc2_]);
            this.FMiddleBackgrounds[_loc2_] = _loc9_;
            _loc2_++;
         }
         this.FMC_Left = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCE_Link_MC_Left];
         this.FMC_Right = this.FGeneralStarMC[CONST_GENERAL_STAR.RESOURCE_Link_MC_Right];
         this.FStarPointBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarPoint);
         this.FStarMapBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_StarMap);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         this.FOpenLevel = _loc1_.Value as uint;
         this.FTFGotoUndertown = this.FGeneralStarMC.MC_GotoUndertown.TF_Text;
         this.FTFGotoUndertown.htmlText = STRING_GENERAL.FormatString_OpenWindow;
         this.FTFGotoUndertown.addEventListener(TextEvent.LINK,this.OpenWindow);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FCloseButton.addEventListener(MouseEvent.CLICK,this.WindowClose);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(this.FReelLeft,true);
         TGameUtil.setButtonMode(this.FReelRight,true);
      }
      
      private function OnChangePage(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TStarMap = null;
         var _loc6_:String = null;
         var _loc7_:TEsotericPoint = null;
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         _loc4_ = 0;
         while(_loc4_ < this.POINT_COUNT.length)
         {
            this.FMiddleBackgrounds[_loc4_].Scene.visible = false;
            _loc4_++;
         }
         if(this.FPageIndex < this.FMapIndex)
         {
            this.FMiddleBackgrounds[this.FPageIndex].AllLight(this.FEsoterics[this.FPageIndex]);
            this.FReelRight.visible = true;
         }
         else
         {
            this.FReelRight.visible = false;
         }
         if(this.FCharacter.StarMapIndex == this.FCharacter.EsotericPoints.GetEsotericPointByIndex(116).Identifier)
         {
            this.FMiddleBackgrounds[this.FPageIndex].AllLight(this.FEsoterics[this.FPageIndex]);
         }
         _loc7_ = this.FEsoterics[0].GetEsotericPointByIndex(0) as TEsotericPoint;
         _loc3_ = _loc7_.MapNum + this.FPageIndex + 17200000;
         _loc5_ = this.FStarMapBin.GetDatebaseByIdentifier(_loc3_) as TStarMap;
         _loc6_ = _loc5_.Name;
         this.FReelName.text = TUtilityString.Format(STRING_GENERAL.FORMAT_NAME,_loc6_);
         this.FMiddleBackgrounds[this.FPageIndex].Scene.visible = true;
         this.FGeneralStarMC.MC_GotoUndertown.visible = this.FPageIndex >= 5 ? true : false;
      }
      
      protected function UpdateUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.POINT_COUNT.length;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function WindowClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(this.FOnHelpTipsOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_Star) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            this.FOnHelpTipsOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.FOnHelpTipsOut != null)
         {
            this.FOnHelpTipsOut(this);
         }
      }
      
      private function SetColour(param1:Boolean, param2:int = 0) : void
      {
         if(param2 == 0)
         {
            this.FEsotericText.textColor = param1 ? uint(4294962020) : uint(4294836224);
         }
         else
         {
            this.FAwakenSoulText.textColor = param1 ? uint(4294962020) : uint(4294836224);
         }
      }
      
      protected function FilterPoint() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TEsotericPoints = null;
         var _loc4_:TEsotericPoint = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = this.POINT_COUNT.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TEsotericPoints();
            _loc6_ = uint(this.POINT_COUNT[_loc1_]);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = this.FEsotericPoints.GetEsotericPointByIndex(_loc5_ + _loc7_);
               _loc3_.AddEsotericPoint(_loc4_);
               _loc5_++;
            }
            _loc7_ += _loc6_;
            this.FEsoterics[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function ShowReel() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TEsotericPoint = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:TStarMap = null;
         var _loc6_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.POINT_COUNT.length)
         {
            this.FMiddleBackgrounds[_loc1_].Scene.visible = false;
            _loc1_++;
         }
         if(this.FCharacter.StarMapIndex == 0)
         {
            this.FMiddleBackgrounds[0].Scene.visible = true;
            this.FMiddleBackgrounds[0].updateGround(0,this.FEsoterics[0]);
            this.FMapIndex = 0;
         }
         else
         {
            _loc2_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
            this.FPageIndex = _loc2_.MapNum - Math.floor(_loc2_.MapNum / 10) * 10 - 2;
            _loc3_ = uint(_loc2_.PointIndex);
            _loc6_ = _loc2_.MapNum + 17200000;
            if(_loc2_.PointIndex == this.POINT_COUNT[this.FPageIndex])
            {
               if(this.FPageIndex != this.POINT_COUNT.length - 1)
               {
                  _loc6_ += 1;
                  this.FPageIndex += 1;
                  _loc3_ = 0;
               }
               else
               {
                  this.FMiddleBackgrounds[this.FPageIndex].AllLight(this.FEsoterics[this.FPageIndex]);
                  this.FReelRight.visible = true;
               }
            }
            _loc5_ = this.FStarMapBin.GetDatebaseByIdentifier(_loc6_) as TStarMap;
            _loc4_ = _loc5_.Name;
            this.FReelName.text = TUtilityString.Format(STRING_GENERAL.FORMAT_NAME,_loc4_);
            this.FMiddleBackgrounds[this.FPageIndex].updateGround(_loc3_,this.FEsoterics[this.FPageIndex]);
            this.FMiddleBackgrounds[this.FPageIndex].Scene.visible = true;
            this.FMapIndex = this.FPageIndex;
         }
      }
      
      private function updatePointAndCo() : void
      {
         var _loc1_:TEsotericPoint = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         var _loc4_:TStarMap = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         _loc1_ = this.FEsotericPoints.GetEsotericPointByIdentifier(this.FCharacter.StarMapIndex) as TEsotericPoint;
         this.FPageIndex = _loc1_.MapNum - Math.floor(_loc1_.MapNum / 10) * 10 - 2;
         if(_loc1_.PointIndex == this.POINT_COUNT[this.FPageIndex])
         {
            if(this.FPageIndex == this.POINT_COUNT.length - 1)
            {
               this.FMiddleBackgrounds[this.FPageIndex].updateGround(_loc1_.PointIndex - 1,this.FEsoterics[this.FPageIndex]);
               return;
            }
            this.FPageIndex += 1;
            this.FMapIndex = this.FPageIndex;
            this.UpdateUIPage();
            _loc2_ = 0;
            _loc5_ = _loc1_.MapNum + 1 + 17200000;
            _loc4_ = this.FStarMapBin.GetDatebaseByIdentifier(_loc5_) as TStarMap;
            _loc3_ = _loc4_.Name;
            this.FReelName.text = TUtilityString.Format(STRING_GENERAL.FORMAT_NAME,_loc3_);
            this.FMiddleBackgrounds[this.FPageIndex].updateGround(_loc2_,this.FEsoterics[this.FPageIndex]);
            _loc8_ = this.FMiddleBackgrounds.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               this.FMiddleBackgrounds[_loc7_].Scene.visible = false;
               _loc7_++;
            }
            this.FMiddleBackgrounds[this.FPageIndex].Scene.visible = true;
            EffectGenerateText(STRING_COMMON.STRING_HeroUpgrade + ColorDescription[_loc4_.Quality]);
            if(this.FOnSetQuality != null)
            {
               this.FOnSetQuality();
            }
         }
         else
         {
            this.FMiddleBackgrounds[this.FPageIndex].updatePointStar(_loc1_);
         }
         this.FEsotericText.text = this.FCharacter.GeneralsSoul.toString();
         this.FAwakenSoulText.text = this.FCharacter.AwakenGeneralsSoul.toString();
      }
      
      protected function OpenSevenStarBtn() : void
      {
         if(this.FSevenStar == null)
         {
            return;
         }
         if(this.FCharacter.GetMainLevel() >= this.FOpenLevel)
         {
            if(!this.FSevenStar.hasEventListener(MouseEvent.CLICK))
            {
               this.FSevenStar.mouseEnabled = true;
               this.FMaskBtn.visible = false;
               this.FSevenStar.addEventListener(MouseEvent.CLICK,this.OpenSevenStar);
            }
            this.FSevenStarTip.visible = false;
         }
         else
         {
            this.FSevenStar.mouseEnabled = false;
            this.FSevenStarTip.visible = true;
         }
      }
      
      protected function PlayAnimation() : void
      {
         this.FMC_Left.gotoAndPlay(1);
         this.FMC_Right.gotoAndPlay(1);
      }
      
      protected function OpenSevenStar(param1:MouseEvent) : void
      {
         if(this.FOnActivityBigDipper != null)
         {
            this.FOnActivityBigDipper(this);
         }
      }
      
      protected function OpenWindow(param1:TextEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks();
         }
      }
      
      public function get OnHelpTipsOver() : Function
      {
         return this.FOnHelpTipsOver;
      }
      
      public function set OnHelpTipsOver(param1:Function) : void
      {
         this.FOnHelpTipsOver = param1;
      }
      
      public function get OnHelpTipsOut() : Function
      {
         return this.FOnHelpTipsOut;
      }
      
      public function set OnHelpTipsOut(param1:Function) : void
      {
         this.FOnHelpTipsOut = param1;
      }
      
      public function get OnPointMove() : Function
      {
         return this.FOnPointMove;
      }
      
      public function set OnPointMove(param1:Function) : void
      {
         this.FOnPointMove = param1;
      }
      
      public function get OnPointOut() : Function
      {
         return this.FOnPointOut;
      }
      
      public function set OnPointOut(param1:Function) : void
      {
         this.FOnPointOut = param1;
      }
      
      public function get OnPointClick() : Function
      {
         return this.FOnPointClick;
      }
      
      public function set OnPointClick(param1:Function) : void
      {
         this.FOnPointClick = param1;
      }
      
      protected function OnTiaoZhuanClickC(param1:int) : void
      {
         if(this.FOnTiaoZhuanClick != null)
         {
            this.FOnTiaoZhuanClick(param1);
         }
      }
      
      public function get OnTiaoZhuanClick() : Function
      {
         return this.FOnTiaoZhuanClick;
      }
      
      public function set OnTiaoZhuanClick(param1:Function) : void
      {
         this.FOnTiaoZhuanClick = param1;
      }
      
      public function get OnSetQuality() : Function
      {
         return this.FOnSetQuality;
      }
      
      public function set OnSetQuality(param1:Function) : void
      {
         this.FOnSetQuality = param1;
      }
      
      public function get OnActivityBigDipper() : Function
      {
         return this.FOnActivityBigDipper;
      }
      
      public function set OnActivityBigDipper(param1:Function) : void
      {
         this.FOnActivityBigDipper = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function init() : void
      {
         if(!this.FIsInit)
         {
            this.FilterPoint();
            this.FIsInit = true;
         }
         this.ShowReel();
         this.FReelRight.visible = false;
         this.UpdateUIPage();
         this.OpenSevenStarBtn();
         this.FEsotericText.text = this.FCharacter.GeneralsSoul.toString();
         this.FAwakenSoulText.text = this.FCharacter.AwakenGeneralsSoul.toString();
         this.PlayAnimation();
         this.FGeneralStarMC.MC_GotoUndertown.visible = this.FPageIndex >= 5 ? true : false;
      }
      
      public function updatePoint() : void
      {
         this.updatePointAndCo();
      }
      
      public function GetGroundByIndex(param1:uint) : TUIMiddleBackground
      {
         return this.FMiddleBackgrounds[param1];
      }
   }
}

