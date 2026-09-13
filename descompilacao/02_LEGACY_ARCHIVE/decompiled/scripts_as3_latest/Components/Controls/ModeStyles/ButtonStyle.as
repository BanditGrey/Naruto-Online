package Components.Controls.ModeStyles
{
   import Components.Controls.Managers.*;
   
   public class ButtonStyle
   {
      
      public static const TEXT_COLOR:String = "textColor";
      
      public static const TEXT_OVER_COLOR:String = "textOverColor";
      
      public static const TEXT_DOWN_COLOR:String = "textDownColor";
      
      public static const ICON_OVER:String = "iconOver";
      
      public static const ICON_DOWN:String = "iconDown";
      
      public static const DEFAULT_SKIN_ELLIPSE_WIDTH:String = "defaultSkinEllipseWidth";
      
      public static const DEFAULT_SKIN_ELLIPSE_HEIGHT:String = "defaultSkinEllipseHeight";
      
      public static const DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH:String = "defaultSkinEllipseBottomWidth";
      
      public static const DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT:String = "defaultSkinEllipseBottomHeight";
      
      public static const TEXT_ALIGN:String = "textAlign";
      
      public static const TEXT_BattlefieldDING:String = "textBattlefieldding";
      
      public function ButtonStyle(param1:Object)
      {
         super();
         param1[TEXT_COLOR] = DefaultStyle.buttonOutTextColor;
         param1[TEXT_OVER_COLOR] = DefaultStyle.buttonOverTextColor;
         param1[TEXT_DOWN_COLOR] = DefaultStyle.buttonDownTextColor;
         param1[DEFAULT_SKIN_ELLIPSE_WIDTH] = 3.5;
         param1[DEFAULT_SKIN_ELLIPSE_HEIGHT] = 3.5;
         param1[DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH] = 3.5;
         param1[DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT] = 3.5;
         param1[ButtonStyle.TEXT_BattlefieldDING] = 5;
      }
   }
}

