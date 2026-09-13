package Processors.Game.Lobby.Wing
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TWingAdvanced;
   import Logics.DatebaseVO.VO.TWingUpgrade;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_MainScene;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TITLE;
   import Resources.Strings.STRING_WING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import ghostcat.util.data.Json;
   
   public class TUIWingStrengthen extends TUIBaseWindow
   {
      
      public static const STAR_COUNT:int = 10;
      
      public static const ATTRIBUTE_COUNT:int = 6;
      
      protected var FWing:TWing;
      
      protected var FTransformWing:TWingAdvanced;
      
      protected var FMC_Wing:Sprite;
      
      protected var FWingBitmap:Bitmap;
      
      protected var FWingPicID:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUIWingStrengthen(param1:TUIComponent)
      {
         super(param1);
         this.FWing = SLogicsCore.Character.Wing;
         this.FWingBitmap = new Bitmap();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FMC_Wing = FMC_Scene.MC_WingPic;
         this.FMC_Wing.addChild(this.FWingBitmap);
         this.FMC_Wing.mouseEnabled = false;
         this.FMC_Wing.mouseChildren = false;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Free,true);
         FMC_Scene.BTN_Free.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeUp);
         FMC_Scene.BTN_Free.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFreeOver);
         FMC_Scene.BTN_Free.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Gold,true);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldUp);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldOver);
         FMC_Scene.BTN_Gold.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Auto,true);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoUp);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAutoOver);
         FMC_Scene.BTN_Auto.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
      }
      
      protected function UpdateWing() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TWingUpgrade = null;
         var _loc4_:TWingUpgrade = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc16_:String = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingUpgrade,this.FWing.WingID) as TWingUpgrade;
         this.FTransformWing = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingAdvanced,this.FWing.TransformID) as TWingAdvanced;
         if(_loc3_)
         {
            this.FWingPicID = _loc3_.textureID;
            FMC_Scene.TF_WingCount.text = this.FWing.ColorfulFeather.toString();
            FMC_Scene.TF_Level.text = _loc3_.name;
            FMC_Scene.TF_EXP.text = this.FWing.CurExp + "/" + _loc3_.needExp;
            _loc5_ = Number(this.FWing.CurExp / _loc3_.needExp) * this.FBarMaxWidth;
            _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
            this.FMC_Mask.width = _loc6_;
            _loc1_ = 0;
            while(_loc1_ < STAR_COUNT)
            {
               FMC_Scene["MC_Star" + _loc1_].visible = _loc1_ < _loc3_.showStarNum ? true : false;
               _loc1_++;
            }
            _loc8_ = Json.decode(_loc3_.addAttribute);
            _loc1_ = 0;
            while(_loc1_ < ATTRIBUTE_COUNT)
            {
               _loc7_ = FMC_Scene["MC_Attribute" + _loc1_];
               if(_loc1_ < _loc8_.length)
               {
                  _loc7_.visible = true;
                  _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc8_[_loc1_][0]);
                  _loc7_.TF_Attribute0.text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_];
                  if(_loc8_[_loc1_][1] <= 3)
                  {
                     _loc16_ = Number(_loc8_[_loc1_][1] * 100).toFixed();
                     _loc7_.TF_BeforeValue.text = _loc16_ + "%";
                  }
                  else
                  {
                     _loc7_.TF_BeforeValue.text = _loc8_[_loc1_][1];
                  }
               }
               else
               {
                  _loc7_.visible = false;
               }
               _loc1_++;
            }
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingUpgrade,this.FWing.WingID + 1) as TWingUpgrade;
            if(_loc4_ != null)
            {
               _loc9_ = Json.decode(_loc4_.addAttribute);
               _loc1_ = 0;
               while(_loc1_ < ATTRIBUTE_COUNT)
               {
                  _loc7_ = FMC_Scene["MC_Attribute" + _loc1_];
                  if(_loc1_ < _loc9_.length)
                  {
                     _loc7_.visible = true;
                     _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc9_[_loc1_][0]);
                     _loc7_.TF_Attribute0.text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_];
                     if(_loc9_[_loc1_][1] <= 3)
                     {
                        _loc16_ = Number(_loc9_[_loc1_][1] * 100).toFixed();
                        _loc7_.TF_AfterValue.text = _loc16_ + "%";
                     }
                     else
                     {
                        _loc7_.TF_AfterValue.text = _loc9_[_loc1_][1];
                     }
                  }
                  else
                  {
                     _loc7_.visible = false;
                  }
                  _loc1_++;
               }
               FMC_Scene.MC_End.visible = false;
            }
            else
            {
               FMC_Scene.MC_End.visible = true;
            }
            if(this.FTransformWing)
            {
               _loc10_ = Json.decode(this.FTransformWing.additionClient);
               if(_loc10_[0].length > 0)
               {
                  _loc14_ = "";
                  _loc1_ = 0;
                  while(_loc1_ < _loc10_.length)
                  {
                     _loc13_ = new ConsumeFrameCopy(_loc10_[_loc1_][0]).DescribeString;
                     _loc2_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc10_[_loc1_][1]);
                     if(_loc10_[_loc1_][2] < 1)
                     {
                        _loc15_ = _loc10_[_loc1_][2] * 100;
                        _loc14_ += TUtilityString.Format(_loc13_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc15_) + "\n";
                     }
                     else
                     {
                        _loc14_ += TUtilityString.Format(_loc13_,STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc10_[_loc1_][2]) + "\n";
                     }
                     _loc1_++;
                  }
               }
               else
               {
                  _loc14_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString;
               }
               FMC_Scene.TF_Buff.text = _loc14_;
               if(this.FTransformWing.duration == 0)
               {
                  FMC_Scene.TF_Time.text = STRING_TITLE.STRING_Forever;
               }
               else
               {
                  FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FWing.TransformTime - STimingCore.GetServerTick());
               }
            }
            else
            {
               FMC_Scene.TF_Buff.text = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString;
               FMC_Scene.TF_Time.text = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_018).DescribeString;
            }
         }
      }
      
      protected function UpdateWingPic() : void
      {
         TGameUtil.ShowAnimationByID(TGameUtil.Type_Wing,this.FWingBitmap,CONST_MODULES.MODULE_Wing,this.FWingPicID,CONST_MainScene.WING_OF_RUN);
         this.FMC_Wing.x = 26 + (436 - this.FMC_Wing.width) / 2;
         this.FMC_Wing.y = 53 + (314 - this.FMC_Wing.width) / 2;
      }
      
      protected function ProcessorOnFreeUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FWing))
         {
            FOnGetBox(TProcessorWing.COIN_STRENGTHEN);
         }
      }
      
      protected function ProcessorOnFreeOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FWing) && this.FWing.StrengthenConfig.length > 1)
         {
            if(this.FWing.CoinCount == 0)
            {
               _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_019).DescribeString;
            }
            else
            {
               _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_001).DescribeString;
               _loc2_ = TUtilityString.Format(_loc2_,this.FWing.CoinPrice,this.FWing.CoinCount);
            }
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      protected function ProcessorOnGoldUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FOnBuyBox != null && Boolean(this.FWing))
         {
            _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_004).DescribeString;
            _loc2_ = TUtilityString.Format(_loc2_,this.FWing.GoldPrice,STRING_WING.Wings_GeneralItemName,this.FWing.GoldCrit,this.FWing.GoldBigCrit,this.FWing.GoldExp);
            FOnBuyBox(TProcessorWing.GOLD_STRENGTHEN,this.FWing.GoldPrice,0,TBaseActivity.SWEET_TYPE_GOLD_GIFT,_loc2_);
         }
      }
      
      protected function ProcessorOnGoldOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FWing) && this.FWing.StrengthenConfig.length > 1)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_002).DescribeString;
            _loc2_ = TUtilityString.Format(_loc2_,this.FWing.GoldPrice,STRING_WING.Wings_GeneralItemName,this.FWing.GoldCrit,this.FWing.GoldBigCrit);
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      protected function ProcessorOnAutoUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FOnBuyBox != null && Boolean(this.FWing))
         {
            _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_005).DescribeString;
            _loc2_ = TUtilityString.Format(_loc2_,this.FWing.AutoPrice,STRING_WING.Wings_GeneralItemName,this.FWing.AutoCrit,this.FWing.AutoBigCrit,this.FWing.AutoExp);
            FOnBuyBox(TProcessorWing.AUTO_STRENGTHEN,this.FWing.AutoPrice,0,TBaseActivity.SWEET_TYPE_GOLD_GIFT,_loc2_);
         }
      }
      
      protected function ProcessorOnAutoOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FWing) && this.FWing.StrengthenConfig.length > 1)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_WING.WINGS_STRING_003).DescribeString;
            _loc2_ = TUtilityString.Format(_loc2_,this.FWing.AutoPrice,STRING_WING.Wings_GeneralItemName,this.FWing.AutoCrit,this.FWing.AutoBigCrit,this.FWing.AutoExp);
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FWingPicID != 0)
            {
               this.UpdateWingPic();
            }
            if(Boolean(this.FTransformWing) && this.FTransformWing.illusionType == 2)
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FWing.TransformTime - STimingCore.GetServerTick());
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateWing();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

